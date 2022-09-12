---
title: '【游戏逆向】聊一聊Funtion Hook/Detour'
comments: true
date: 2020-12-14 15:04:29
tags:
    - 游戏逆向
    - HOOK
categories:
    - [不亦乐乎]
---
__摘要：__
聊一聊游戏外挂开发中常用的HOOK技术。
<!-- more -->

```C++
#include <Windows.h>

/*
* toHook: the memory address where we place the jmp
* ourFunct: the memory address where we place our function
* len: the numbers of bytes used by the instruction you're overwritting(typically 5 but deppending what we overwrrite it maybe more)
*/
bool Hook(void * toHook, void * ourFunct, int len) {                        
    if (len < 5) {                                                          // 1
        return false;
    }

    DWORD curProtection;
    VirtualProtect(toHook, len, PAGE_EXECUTE_READWRITE, &curProtection);    // 2

    memset(toHook, 0x90, len);                                              // 3

    DWORD relativeAddress = ((DWORD)ourFunct - (DWORD)toHook) - 5;          // 4

    *(BYTE*)toHook = 0xE9;                                                  // 5
    *(DWORD*)((DWORD)toHook + 1) = relativeAddress;

    DWORD temp;                                         
    VirtualProtect(toHook, len, curProtection, &temp);                      // 6

    return true;
}

DWORD jmpBackAddy;
void __declspec(naked) outFunct() {                                         // 7
    _asm {                                                                  // 8
        add ecx, ecx                                                        // 9
		mov edx, [ebp - 8]                                                  // 10
        jmp[jmpBackAddy]                                                    // 11
    }

}

DWORD WINAPI MainThread(LPVOID param) {
	/* the assembly lines where we are going to hook is looks like this :
		2B 4D 08      subecx, [ebp + 08]
		8B 55 F8      movedx, [ebp - 08]
		89 0A         mov[edx], ecx
	*/
	int hookLength = 6;	//There are 3 bytes(< 5) in the first line, the hook funtion contains at least 1 `jmp` instrution(5 bytes) 
						// so that the offset length should be at least 5. But if we are using 5, we can only override the first line
						// and part of second line.
	DWORD hookAddress = 0x8d2768;	// signature if this address: 2B 4D 08 8B 55 F8
	jmpBackAddy = hookAddress + hookLength;

	Hook((void*)hookAddress, ourFunct, hookLength);

	while (true) {
		if (GetAsyncKeyState(VK_ESCAPE)) break;
		Sleep(50);
	}

	FreeLibraryAndExitThread((HMODULE)param, 0);

	return 0;
}

BOOL WINAPI DllMain(HINSTANCE hModule, DWORD dwReason, LPVOID lpReserved) {
    switch (dwReason) {
    case DLL_PROCESS_ATTACH:
        CreateThread(0, 0, MainThread, hModule, 0, 0);
        break;
    }

    return TRUE;
}
```
> 1. We check the length to be at least 5 bytes because this is the smallest relative jmp in x86. The instructions you will be destroying by overwriting will be at least 5 bytes. In a word, we have at least a `jmp` opcode at that address, and the `jmp` opcode is going to be at least 5 bytes;
> 2. We use VirtualProtect to take permissions of the memory we are overwriting.
> 3. We set the memory we're ovewriting with 0x90 which is the NOP (no operationg) instruction, this is not 100% necessary but is a nice failsafe measure. While you're debugging it's also nice to watch the 0x90 get written so you know you're doing the right thing in the right spot. We NOP the entire instruction by giving it the len argument.
> 4. Then we calculate the relative address between the destination and src address by subtracting them, we subtract len. The result of this calculation is the relative offset from the last byte we overwrote to the address of our function we are jumping to. Keep in mind, we are using a relative jump, not an absolute jump so this must be calculated at runtime.
> 5. Then we write 0xE9(byte code) which is the relative jmp instruction, then we add 1 byte(0xE9) so we can write the relative offset.
> 6. Then we use VirtualProtect to reset the page permissions to what they were before we modified them.
> 7. You have to execute your code inside a declspec naked function, you must preserve the registers and the stack so you don't corrupt the stack of registers and you must execute the stolen bytes. Then you have to jump back to the src+len address.
The `__declspec(naked)` indicates that the function is going to be no epilogue and prologue. And we can write assembly code in it.
> 8. The `_asm` indicates no other assembly code but ours.
> 9. This line is our own code, which replaces the original one (`subecx, [ebp + 08]`) to __add__ whole health value while pressing SPACE button;
> 10. The `hookLength` we are using(6) overrides the second assembly line although we don't need to override to execute our code so that we have to re-write it;
> 11. After 