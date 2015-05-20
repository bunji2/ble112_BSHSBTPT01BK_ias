#
# nmake 用 Makefile
# BGAPIのサンプルコーディング
#
# ●実行例
# nmake -f bled.mak
#
# ●必要なDLL
# なし

MT=mt
CP=copy
RM=del

INC_DIR=.

CFLAG=/nologo /W3 /DWIN32 /D_WIN32 $(CFLAG) /I $(INC_DIR)
LINKFLAG=/nologo

LIBS=setupapi.lib

default: buildall

buildall:	ias.exe

clean:
	$(RM) *.obj *.exe *.manifest *.bak

.c.obj:
	$(CC) /c /Fo$@ $< $(CFLAG)

uart.obj:	uart.h

cmd_def.obj:	cmd_def.h

stubs.obj:	cmd_def.h

main.obj:	cmd_def.h uart.h

main_ias.obj:	cmd_def.h uart.h

ias.exe:	main_ias.obj stubs.obj cmd_def.obj uart.obj
	$(CC) /Fe$@ main_ias.obj stubs.obj cmd_def.obj uart.obj $(LINKFLAG) /link $(LIBS)
	IF EXIST $@.manifest $(MT) -manifest $@.manifest -outputresource:$@
