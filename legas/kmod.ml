(* sudo apt install -uy kmod kbuild dkms *)

let kc () =
  touch ("src/kmod/"^app^".c") ~c:("#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

MODULE_LICENSE(\"GPL\");  // "^license^"
MODULE_AUTHOR(\""^author^" <"^email^">\");
MODULE_DESCRIPTION(\""^title^"\");
MODULE_VERSION(\""^version^"\");

static int __init "^app^"_init(void) {
    pr_info(KERN_INFO \""^app^": init\\n\");
    return 0;
}

static void __exit "^app^"_exit(void) {
    pr_info(KERN_INFO \""^app^": exit\\n\");
}

module_init("^app^"_init);
module_exit("^app^"_exit);
") ()

let kbuild () =
  touch "src/kmod/Kbuild" ~c:("obj-m := "^app^".o") ()

let kmake () =
  touch "src/kmod/Makefile" ~c:("APP = "^app^"
KO  = $(APP).ko
  
obj-m += $(APP).o

.PHONY: all run clean

all: $(KO)
$(KO): *.c Makefile
\tmake -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

run: $(KO)
\tsudo rmmod $<
\tsudo insmod $<
\tsudo dmesg | tail -n11

clean:
\tmake -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
") ()

let kgiti () =
  touch "src/kmod/.gitignore" ~c:"*.ko
*.o
*.mod*
*.cmd
?odule*
!.gitignore
" ()

let kmk () =
  touch "mk/kmod.mk" ~c:"kmod:\n\tcd src/kmod ; make run" ()

let kmod () =
  mkd ("src/kmod") ();
  kc ();
  kmake ();
  kgiti ();
  kmk ()
