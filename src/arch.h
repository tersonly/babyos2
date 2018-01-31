/*
 * guzhoudiaoke@126.com
 * 2017-10-26
 */

#ifndef _ARCH_H_
#define _ARCH_H_

#include "kernel.h"
#include "keyboard.h"
#include "timer.h"
#include "cpu.h"
#include "i8259a.h"
#include "i8254.h"
#include "io_apic.h"

class arch_t {
public:
    arch_t();
    ~arch_t();

    void init();
	void update();

    cpu_t*      get_cpu();
    i8259a_t*   get_8259a();
    keyboard_t* get_keyboard();
    i8254_t*    get_8254();
    rtc_t*      get_rtc();
    io_apic_t*  get_io_apic();

private:
    cpu_t		m_cpu;
    i8259a_t	m_8259a;
    keyboard_t  m_keyboard;
    i8254_t     m_8254;
    rtc_t       m_rtc;
    io_apic_t   m_io_apic;
};

#endif
