#include <linux/hrtimer.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/ktime.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");  // MIT
MODULE_AUTHOR("Dmitry Ponyatov <dponyatov@gmail.com>");
MODULE_DESCRIPTION("precision timers on server-side Linux");
MODULE_VERSION("0.0.1");

static struct hrtimer timer;
static ktime_t interval;

static uint64_t prev_ns;
static uint64_t curr_ns;

static uint64_t prev_delta;
static uint64_t delta;

static enum hrtimer_restart timer_callback(struct hrtimer *timer) {
    ktime_t now = timer->base->get_time();
    prev_ns = curr_ns;
    curr_ns = ktime_to_ns(now);
    prev_delta = delta;
    delta = curr_ns - prev_ns;
    pr_info(KERN_INFO                                       //
            "prectimer: jiffies:%ld ns:%lld delta:%lld\n",  //
            jiffies, curr_ns, delta);
    hrtimer_forward_now(timer, interval);
    return HRTIMER_RESTART;  // Или HRTIMER_RESTART
}

static int __init prectimer_init(void) {
    pr_info(KERN_INFO "prectimer: init\n");
    interval = ktime_set(0, 100000);  // seconds, nanoseconds
    hrtimer_init(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
    timer.function = &timer_callback;
    hrtimer_start(&timer, interval, HRTIMER_MODE_REL_HARD);
    return 0;
}

static void __exit prectimer_exit(void) {
    while (hrtimer_cancel(&timer)) {}
    // pr_info(KERN_INFO "prectimer: still active\n");
    pr_info(KERN_INFO "prectimer: exit\n");
}

module_init(prectimer_init);
module_exit(prectimer_exit);
