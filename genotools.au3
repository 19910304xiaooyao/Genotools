#region ;**** ���������� ACNWrapper_GUI ****
#PRE_Icon=Geno.logo.ico
#PRE_Outfile=Genotools-C8812.exe
#PRE_UseUpx=n
#PRE_UseX64=n
#PRE_Res_Comment=��ŵС���߳���
#PRE_Res_Description=��ΪU8818/C8818�ֻ�ר�õ�С����
#PRE_Res_LegalCopyright=��ŵ Genokolar@gmail.com
#PRE_Res_requestedExecutionLevel=None
#endregion ;**** ���������� ACNWrapper_GUI ****
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
GUICreate("��ŵ������ ������̳", 300, 520)
GUISetFont(12)
dircreate(@TempDir & "\geno")
FileInstall("AdbWinApi.dll", @TempDir & "\geno\AdbWinApi.dll")
FileInstall("AdbWinUsbApi.dll", @TempDir & "\geno\AdbWinUsbApi.dll")
FileInstall("bootimg.exe", @TempDir & "\geno\bootimg.exe")
FileInstall("load_oemlogo", @TempDir & "\geno\load_oemlogo")
FileInstall("hwadb.exe", @TempDir & "\geno\hwadb.exe")
FileInstall("7z.exe", @TempDir & "\geno\7z.exe")
FileInstall("su", @TempDir & "\geno\su")
FileInstall("root.sh", @TempDir & "\geno\root.sh")
FileInstall("Superuser.apk", @TempDir & "\geno\Superuser.apk")
FileInstall("mempodroid", @TempDir & "\geno\mempodroid")
FileInstall("geno.jpg", @TempDir & "\geno\geno.jpg")
FileInstall("flash_image", @TempDir & "\geno\flash_image")
FileInstall("busybox", @TempDir & "\geno\busybox")
Opt("TrayIconHide", 1)
;���ò���,recovery������root��offsetֵ
$offset = "0xd524 0xab8f"  
$RECP = "/dev/block/mmcblk0p16"


$isrooted = "root"
$islink = "unlink"

$MenuItem1 = GUICtrlCreateMenu("����")
$MenuItem2 = GUICtrlCreateMenuItem("ʹ��˵��", $MenuItem1)
GUICtrlSetOnEvent(-1, "help")
$MenuItem3 = GUICtrlCreateMenuItem("����", $MenuItem1)


GUICtrlCreatePic(@TempDir & "\geno\geno.jpg", 0, 0, 300, 59)
GUICtrlSetTip(-1, "��ӭ���ʰ�����̳��ø�����Դ����Ϣ�����֧�����ҵĶ���--����������ŵ������")
$TEXT = GUICtrlCreateLabel("�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ������Ƚ��ֻ�ROOT����ִ���������������������Ϣ��ť��ȡ����C8812��U8818����Ϣ", 10, 68, 280, 80)
GUICtrlSetTip(-1, "������-��ŵ genokolar ��������")
$root = GUICtrlCreateButton("ROOT�ֻ�", 80, 150, 140, 36)
GUICtrlSetTip(-1, "ͨ��ADB����ROOT����ֻ���")
$unroot = GUICtrlCreateButton("UNROOT�ֻ�", 80, 150, 140, 36)
GUICtrlSetTip(-1, "ͨ��ADB����UNROOT����ֻ���")
$recovery = GUICtrlCreateButton("ˢ��recovery", 80, 200, 140, 36)
GUICtrlSetTip(-1, "ѡ��һ��recovery�����ļ��������߽��Զ�Ϊ�����recovery��")
$logo = GUICtrlCreateButton("������һ��", 80, 250, 140, 36)
GUICtrlSetTip(-1, "ѡ��һ��480*800��JPGͼƬ�������߽��Զ�Ϊ�����������һ��LOGO��")
$lite = GUICtrlCreateButton("����ϵͳ", 80, 300, 140, 36)
GUICtrlSetTip(-1, "ѡ��һ�������б������߽��Զ�Ϊ�㾫�����ϵͳ��")
$patch = GUICtrlCreateButton("��װ����", 80, 350, 140, 36)
GUICtrlSetTip(-1, "ѡ��һ�������ļ��������߽��Զ�Ϊ����ϲ������ʺ������ֻ�����ҪROOTȨ�ޡ�")
$help = GUICtrlCreateButton("������Ϣ", 80, 400, 140, 36)
GUICtrlSetTip(-1, "��ȡ����C8812��U8818�Ȼ�Ϊ�ֻ�����Դ����Ϣ��")
$Cancel = GUICtrlCreateButton("�˳�����", 80, 450, 140, 36)
GUICtrlSetTip(-1, "�˳������ߣ�")
;Opt("GUIOnEventMode", 1)
;GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
;GUICtrlSetOnEvent($Cancel, "_Exit")
#testlink()
testsu()
GUISetState()
While 1; ���нű�ֱ�����ڱ��ر�
	$msg = GUIGetMsg()
	Select
		Case $msg = $root
			rootphone()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $unroot
			unrootphone()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $logo
			changelogo()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $recovery
			changerecovery()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $lite
			litesystem()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $patch
			INSTALLZIP()
			GUICtrlSetData($TEXT, "�˳���������ڻ�ΪC8812��U8818���ֻ����������������ֻ���������Ϣ���������Ϣ��ť��ȡ����C8812��U8818����Ϣ")
		Case $msg = $help
			_RunDOS("start Http://weibo.com/geno")
			_RunDOS("start http://www.iamgeno.com")

		Case $msg = $Cancel
			DELINSTALL()
			_Exit()
		Case $msg = $GUI_EVENT_CLOSE
			DELINSTALL()
			ExitLoop

	EndSelect
WEnd

Func testlink()
	FileDelete(@TempDir & "\geno\sh")
	Local $adb = @TempDir & "\geno\hwadb"
	If ProcessExists("adb.exe") Then $adb = "adb"
	_RunDOS($adb & " pull /system/bin/sh " & @TempDir & "\geno\sh")
	_RunDOS($adb & " pull /system/bin/mksh " & @TempDir & "\geno\sh")
	If FileExists(@TempDir & "\geno\sh") Then
		$islink = "link"
		testsu()
	Else
		MsgBox(4096, "����ʧ��", "��⵽�޷���ȷ���ӵ�����ֻ�������ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ������ԡ�", 0)
		$islink = "unlink"
	EndIf
EndFunc   ;==>testlink

Func testlink2()
	FileDelete(@TempDir & "\geno\sh")
	Local $adb = @TempDir & "\geno\hwadb"
	If ProcessExists("adb.exe") Then $adb = "adb"
	_RunDOS($adb & " pull /system/bin/sh " & @TempDir & "\geno\sh")
	_RunDOS($adb & " pull /system/bin/mksh " & @TempDir & "\geno\sh")
	If FileExists(@TempDir & "\geno\sh") Then
		$islink = "link"
		testsu2()
	Else
		MsgBox(4096, "����ʧ��", "��⵽�޷���ȷ���ӵ�����ֻ�������ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ������ԡ�", 0)
		$islink = "unlink"
	EndIf
EndFunc   ;==>testlink2

Func testsu()
	FileDelete(@TempDir & "\geno\subin")
	Local $adb = @TempDir & "\geno\hwadb"
	If ProcessExists("adb.exe") Then $adb = "adb"
	_RunDOS($adb & " pull /system/bin/su " & @TempDir & "\geno\subin")
	_RunDOS($adb & " pull /system/xbin/su " & @TempDir & "\geno\subin")
	If FileExists(@TempDir & "\geno\subin") Then
		GUICtrlSetState($root, $GUI_HIDE)
		GUICtrlSetState($unroot, $GUI_SHOW)
		$isrooted = "root"
	Else
		GUICtrlSetState($unroot, $GUI_HIDE)
		GUICtrlSetState($root, $GUI_SHOW)
		$isrooted = "unroot"
	EndIf
EndFunc   ;==>testsu

Func testsu2()
	FileDelete(@TempDir & "\geno\subin")
	Local $adb = @TempDir & "\geno\hwadb"
	If ProcessExists("adb.exe") Then $adb = "adb"
	_RunDOS($adb & " pull /system/bin/su " & @TempDir & "\geno\subin")
	_RunDOS($adb & " pull /system/xbin/su " & @TempDir & "\geno\subin")
	If FileExists(@TempDir & "\geno\subin") Then
		GUICtrlSetState($root, $GUI_HIDE)
		GUICtrlSetState($unroot, $GUI_SHOW)
		$isrooted = "root"
	Else
		GUICtrlSetState($unroot, $GUI_HIDE)
		GUICtrlSetState($root, $GUI_SHOW)
		MsgBox(4096, "�ֻ�û��ROOT", "����ֻ�û��ROOT����������ȷִ�д˲���,����ROOT�ֻ������ͨ��ROOT��������ROOT������Ե��������Ϣ��ť�������߲��ͻ�ȡROOT�İ�������", 0)
		$isrooted = "unroot"
	EndIf
EndFunc   ;==>testsu2

Func sumessage()
	FileDelete(@TempDir & "\geno\subin")
	Local $adb = @TempDir & "\geno\hwadb"
	If ProcessExists("adb.exe") Then $adb = "adb"
	_RunDOS($adb & " pull /system/bin/su " & @TempDir & "\geno\subin")
	_RunDOS($adb & " pull /system/xbin/su " & @TempDir & "\geno\subin")
	If FileExists(@TempDir & "\geno\subin") Then
		GUICtrlSetState($root, $GUI_HIDE)
		GUICtrlSetState($unroot, $GUI_SHOW)
		MsgBox(4096, "��ʾ", "����ֻ�����ROOT״̬��", 0)
	Else
		GUICtrlSetState($unroot, $GUI_HIDE)
		GUICtrlSetState($root, $GUI_SHOW)
		MsgBox(4096, "��ʾ", "����ֻ�����δROOT״̬��", 0)
	EndIf
EndFunc   ;==>sumessage

Func rootphone()
	testlink()
	If $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		GUICtrlSetData($TEXT, "���������ļ����ֻ�...")
		_RunDOS($adb & " push " & @TempDir & "\geno\mempodroid /data/local/tmp")
		_RunDOS($adb & " push " & @TempDir & "\geno\su /data/local/tmp")
		_RunDOS($adb & " push " & @TempDir & "\geno\busybox /data/local/tmp")
		_RunDOS($adb & " push " & @TempDir & "\geno\Superuser.apk /data/local/tmp")
		_RunDOS($adb & " push " & @TempDir & "\geno\root.sh /data/local/tmp")
		GUICtrlSetData($TEXT, "ROOT/UNROOT����ֻ���...")
		_RunDOS($adb & " shell chmod 0777 /data/local/tmp/mempodroid ")
		_RunDOS($adb & " shell chmod 0777 /data/local/tmp/root.sh ")
		Local $RC1 = _RunDOS($adb & " shell /data/local/tmp/mempodroid " & $offset & " sh /data/local/tmp/root.sh")
		Local $RC2 = _RunDOS($adb & " shell su -c 'echo ok' ")

		If $RC1 <> 0 Or $RC2 <> 0 Then
			MsgBox(4096, "ִ��ʧ��", "ִ��ʧ�ܣ�����ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
		Else
			sumessage()
		EndIf
	EndIf
EndFunc   ;==>rootphone

Func unrootphone()
	testlink()
	If $isrooted == "root" And $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		GUICtrlSetData($TEXT, "UNROOT����ֻ���...")
		Local $RC1 = _RunDOS($adb & " shell su -c 'mount -o remount,rw /system; rm /system/app/Superuser.apk;rm /system/bin/su; rm /system/xbin/su' ")
		If $RC1 <> 0 Then
			MsgBox(4096, "ִ��ʧ��", "ִ��ʧ�ܣ�����ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
		Else
			sumessage()
		EndIf
	EndIf
EndFunc   ;==>unrootphone

Func changelogo()
	testlink2()
	If $isrooted == "root" And $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		Local $message = "ѡ��һ��JPGͼƬ�ļ�."
		Local $var = FileOpenDialog($message, @WindowsDir & "\", "ͼ���ļ� (*.jpg)", 1 + 2)
		If @error Then
			MsgBox(4096, "������ֹ", "û��ѡ���ļ�!")
		Else
			$var = StringReplace($var, "|", @CRLF)
			MsgBox(4096, "��ʾ", "��ѡ����:" & $var)

			GUICtrlSetData($TEXT, "������һ���У���Լ��Ҫ��������ң������ĵȴ�...")
			Local $RC1 = _RunDOS(@TempDir & "\geno\bootimg.exe --repack-565 " & $var & " " & @TempDir & "\geno\oemlogo.mbn")
			_RunDOS($adb & " shell su -c 'rm -r /data/cust/logo'")
			_RunDOS($adb & " shell su -c 'mkdir -p /data/cust/logo'")
			_RunDOS($adb & " push " & @TempDir & "\geno\oemlogo.mbn /data/cust/logo")
			_RunDOS($adb & " push " & @TempDir & "\geno\load_oemlogo /data/local/tmp")
			_RunDOS($adb & " shell chmod 0755 /data/local/tmp/load_oemlogo")
			_RunDOS($adb & " shell  su -c 'chown 0.0 /data/local/tmp/load_oemlogo' ")
			Local $RC2 = _RunDOS($adb & " shell  su -c '/data/local/tmp/load_oemlogo' ")
			If $RC1 <> 0 Or $RC2 <> 0 Then
				MsgBox(4096, "����ʧ��", "����ʧ�ܣ�����ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			Else
				MsgBox(4096, "�������", "������ɣ������δ�ɹ�������һ��������ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>changelogo

Func changerecovery()
	testlink2()
	If $isrooted == "root" And $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		Local $message = "ѡ��recovery�����ļ�."
		Local $var = FileOpenDialog($message, @WindowsDir & "\", "recovery���� (*.img)", 1 + 2)
		If @error Then
			MsgBox(4096, "������ֹ", "û��ѡ���ļ�")
		Else
			$var = StringReplace($var, "|", @CRLF)
			MsgBox(4096, "��ʾ", "��ѡ����:" & $var)

			GUICtrlSetData($TEXT, "����recovery�У���ȴ�...")
			_RunDOS($adb & " push " & @TempDir & "\geno\flash_image /data/local/tmp")
			_RunDOS($adb & " shell chmod 0755 /data/local/tmp/flash_image")
			Local $RC1 = _RunDOS($adb & " push " & $var & " /data/local/tmp/recovery.img")
			Local $RC2 = _RunDOS($adb & " shell  su -c '/data/local/tmp/flash_image " & $RECP & " /data/local/tmp/recovery.img' ")
			If $RC1 <> 0 Or $RC2 <> 0 Then
				MsgBox(4096, "ˢ��ʧ��", "ˢ��ʧ�ܣ�����ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			Else
				MsgBox(4096, "ˢ�����", "ˢ����ɣ������δ�ɹ�ˢ��Recovery������ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>changerecovery

Func litesystem()
	testlink2()
	If $isrooted == "root" And $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		Local $message = "ѡ�񾫼��ļ��б�."
		Local $var = FileOpenDialog($message, @WindowsDir & "\", "�����б� (*.txt)", 1 + 2)
		If @error Then
			MsgBox(4096, "������ֹ", "û��ѡ���ļ�")
		Else
			$var = StringReplace($var, "|", @CRLF)
			MsgBox(4096, "��ʾ", "��ѡ����:" & $var)

			GUICtrlSetData($TEXT, "�������ϵͳ�У����Ժ�...")
			Local $RC1 = _RunDOS($adb & " push " & $var & " /data/local/tmp/litelist.txt")
			Local $RC2 = _RunDOS($adb & " shell su -c 'mount -o remount,rw /system;mount -o remount,rw /cust; list=`cat /data/local/tmp/litelist.txt`; for files in $list; do rm -r $files ;done; rm -r /data/local/tmp/* ' ")

			If $RC1 <> 0 Or $RC2 <> 0 Then
				MsgBox(4096, "����ʧ��", "����ʧ�ܣ�����ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			Else
				MsgBox(4096, "�������", "������ɣ������δ�ɹ�����ϵͳ������ȷ��װ�ֻ�������ȷ���ֻ�������ADB���ԣ�Ȼ���ֻ����ӵ��Ժ����ԡ�", 0)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>litesystem

Func DELINSTALL()
	FileDelete(@TempDir & "\geno\AdbWinApi.dll")
	FileDelete(@TempDir & "\geno\AdbWinUsbApi.dll")
	FileDelete(@TempDir & "\geno\hwadb.exe")
	FileDelete(@TempDir & "\geno\su")
	FileDelete(@TempDir & "\geno\Superuser.apk")
	FileDelete(@TempDir & "\geno\mempodroid")
	FileDelete(@TempDir & "\geno\geno.jpg")
	FileDelete(@TempDir & "\geno\root.sh")
	FileDelete(@TempDir & "\geno\flash_image")
	FileDelete(@TempDir & "\geno\busybox")
	FileDelete(@TempDir & "\geno\7z.exe")
	FileDelete(@TempDir & "\geno\bootloader.img")
	FileDelete(@TempDir & "\geno\oemsbl.img")
	FileDelete(@TempDir & "\geno\bootimg.exe")
	FileDelete(@TempDir & "\geno\load_oemlogo")
	FileDelete(@TempDir & "\geno\sh")
	FileDelete(@TempDir & "\geno\subin")
EndFunc   ;==>DELINSTALL

Func INSTALLZIP()
	testlink2()
	If $isrooted == "root" And $islink == "link" Then
		Local $adb = @TempDir & "\geno\hwadb"
		If ProcessExists("adb.exe") Then $adb = "adb"
		;ѡ�񲹶��ļ�
		Local $message = "ѡ�񲹶��ļ�."
		Local $var = FileOpenDialog($message, @WindowsDir & "\", "������ (*.zip)", 1 + 2)
		If @error Then
			MsgBox(4096, "������ֹ", "û��ѡ���ļ�")
		Else
			$var = StringReplace($var, "|", @CRLF)
			MsgBox(4096, "��ʾ", "��ѡ����:" & $var)
			_RunDOS("rmdir /S/Q " & @TempDir & "\geno\tmp_geno")
			GUICtrlSetData($TEXT, "��ѹ�������У���ȴ�...")
			;MsgBox(4096, "��ʾ", @TempDir & "\geno\7z.exe x " & $var & " -o" & @TempDir & "\geno\tmp_geno")
			_RunDOS(@TempDir & "\geno\7z.exe x " & $var & " -aoa -o" & @TempDir & "\geno\tmp_geno")

			;��ʼ��װ����............................................................
			; ��װAPK�ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\app\*.apk")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/app")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS(@TempDir & "\geno\7z.exe e " & @TempDir & "\geno\tmp_geno\system\app\" & $file & " -aoa -o" & @TempDir & "\geno\tmp_geno\libs *.so -r")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\app\" & $file & " /data/local/tmp/app/")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/app ; cat ' & $file & ' > /system/app/' & $file & ' ; chmod 0644 /system/app/' & $file & ' ; rm /data/local/tmp/app/* " ')
				WEnd
				FileClose($search)
			EndIf
			;��װ���ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\lib\*.so")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/lib")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\lib\" & $file & " /data/local/tmp/lib/")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/lib ; cat ' & $file & ' > /system/lib/' & $file & ' ; chmod 0644 /system/lib/' & $file & ' ; rm /data/local/tmp/lib/* " ')
				WEnd
				FileClose($search)
			EndIf
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\libs\*.so")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/lib")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\libs\" & $file & " /data/local/tmp/lib/")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/lib ; cat ' & $file & ' > /system/lib/' & $file & ' ; chmod 0644 /system/lib/' & $file & ' ; rm /data/local/tmp/lib/* " ')
				WEnd
				FileClose($search)
			EndIf
			;��װ����ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\framework\*")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/framework")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\framework\" & $file & " /data/local/tmp/framework/")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/framework ; cat ' & $file & ' > /system/framework/' & $file & ' ; chmod 0644 /system/framework/' & $file & ' ; rm /data/local/tmp/framework/* " ')
				WEnd
				FileClose($search)
			EndIf
			;��װȨ���ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\etc\permissions\*.xml")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/etc/permissions")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\etc\permissions\" & $file & " /data/local/tmp/etc/permissions")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/etc/permissions ; cat ' & $file & ' > /system/etc/permissions/' & $file & ' ; chmod 0644 /system/etc/permissions/' & $file & ' ; rm /data/local/tmp/etc/permissions/* " ')
				WEnd
				FileClose($search)
			EndIf
			;��װBin�ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\bin\*")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/bin")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\bin\" & $file & " /data/local/tmp/bin")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/bin ; cat ' & $file & ' > /system/bin/' & $file & ' ; chmod 0755 /system/bin/' & $file & ' ; rm /data/local/tmp/bin/* " ')
				WEnd
				FileClose($search)
			EndIf
			;��װ�����ļ�
			$search = FileFindFirstFile(@TempDir & "\geno\tmp_geno\system\fonts\*")
			If $search = -1 Then
				FileClose($search)
			Else
				_RunDOS($adb & " shell mkdir -p /data/local/tmp/fonts")
				While 1
					$file = FileFindNextFile($search)
					If @error Then ExitLoop
					GUICtrlSetData($TEXT, "��װ" & $file & "...")
					_RunDOS($adb & " push " & @TempDir & "\geno\tmp_geno\system\fonts\" & $file & " /data/local/tmp/fonts")
					_RunDOS($adb & ' shell su -c " mount -o remount rw /system ; cd /data/local/tmp/fonts ; cat ' & $file & ' > /system/fonts/' & $file & ' ; chmod 0644 /system/fonts/' & $file & ' ; rm /data/local/tmp/fonts/* " ')
				WEnd
				FileClose($search)
			EndIf
			_RunDOS($adb & " shell rm -r /data/local/tmp/*")
			_RunDOS("rmdir /S/Q " & @TempDir & "\geno\tmp_geno")
			MsgBox(0, "��װ���", "�����Ѿ���װ��ɣ��������Ҫ�����ֻ���ʹĳЩ������Ч�������װ�������ֻ������Զ����������������滻�ؼ��ļ����µģ���ô����Ҫ�ٰ�װ����һ��", 15)
		EndIf
	EndIf
EndFunc   ;==>INSTALLZIP

Func help() ;�˳�
	;$helptip = ToolTip("��ʱû�а�����Ϣ")
	ToolTip("���ڽ�ѹϵͳ��������ʱ��ϳ����������Ժ�Ƭ�̡�������", "", "", "��װ֪ͨ", "", "1")
EndFunc   ;==>help

Func _Exit() ;�˳�

	Exit
EndFunc   ;==>_Exit

