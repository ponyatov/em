# Error: registers may not be the same

`Error registers may not be the same -- strexh r0,r0,[r1]`

- https://we.easyelectronics.ru/PahanMenski/gcc-46-i-cmsis-ispravlyaem-oshibku-kompilyacii.html

использование одного и того же регистра в качестве первого и второго операндов данных команд приводит, согласно спецификации [[armv7-m]], к неопределенному поведению

![[mcu/strex]]
