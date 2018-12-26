unit SS13_WP_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, tlhelp32, shellapi, PSAPI;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  version_STR = '0.2';
  tiles_CNTR = 15;
  tiles_horz = 32;
  offset_horz_x = $2F7294;
  offset_horz_y = $2FB854;
  offset_CNTR = $2F7298;
var
  Form1: TForm1;
  DreemSeeker_PID: Cardinal;

implementation

{$R *.dfm}

function GetModuleBaseAddress(PHandle: Thandle; MName: String): Pointer;
var
  Modules         : Array of HMODULE;
  cbNeeded, i     : Cardinal;
  ModuleInfo      : TModuleInfo;
  ModuleName      : Array[0..MAX_PATH] of Char;
 // Melong : LongBool;
begin
  Result := nil;
  SetLength(Modules, 1024);
  //cbNeeded := 0;
  if (PHandle <> 0) then
  begin
    try
     EnumProcessModules(PHandle, @Modules[0], 1024 * SizeOf(HMODULE),cbNeeded);
    except
      Exit;
    end;
    SetLength(Modules, cbNeeded div SizeOf(HMODULE)); //Setting the number of modules
   if (Length(Modules) > 0) then
   begin
    for i := 0 to Length(Modules) - 1 do //Start the loop
    begin
      try
        GetModuleBaseName(PHandle, Modules[i], ModuleName, SizeOf(ModuleName));
        if (Pos(MName, ModuleName) > 0) then
        begin
          GetModuleInformation(PHandle, Modules[i], @MoDuleInfo, SizeOf(ModuleInfo));
          Result := ModuleInfo.lpBaseOfDll;
          Exit;
        end;
      Except
      end;
    end;
   end;
  end;
end;

function GetAdrValue(PID: cardinal; Addres: cardinal; ByteType: size_T;
  var GetValue: integer): Boolean;
var
  {PID,} PH: cardinal;
  rw: size_T;
  exec: Boolean;
begin
  exec := true;
  if PID = 0 then
    exec := false;
  //getwindowthreadprocessid(h, PID);
  PH := openprocess(process_all_access, false, PID);
  if PH = 0 then
    exec := false;
  if readprocessmemory(PH, ptr(Addres), @GetValue, ByteType, rw) = false then
    exec := false;
  closehandle(PH);
  result := exec;
end;

function SetAdrValue(PID: cardinal; Addres: cardinal; ByteType: Size_T;
  NewValue: cardinal): Boolean;
var
  {PID,} PH: cardinal;
  rw: size_T;
  exec: Boolean;
begin
  exec := true;
  if PID = 0 then
    exec := false;
  //getwindowthreadprocessid(h, PID);
  PH := openprocess(process_all_access, false, PID);
  if PH = 0 then
    exec := false;
  if writeprocessmemory(PH, ptr(Addres), @NewValue, ByteType, rw) = false then
    exec := false;
  closehandle(PH);
  result := exec;
end;

function GetProcessId(pName: PChar): dword;
var
 Snap: dword;
 Process: TPROCESSENTRY32;
begin
  Result := 0;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
      Process.dwSize := SizeOf(TPROCESSENTRY32);
      if Process32First(Snap, Process) then
         repeat
          if lstrcmpi(Process.szExeFile, pName) = 0 then
             begin
              Result := Process.th32ProcessID;
              CloseHandle(Snap);
              Exit;
             end;
         until not Process32Next(Snap, Process);
      Result := 0;
      CloseHandle(Snap);
     end;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
 ByondCore_dll_p : Pointer;
 ProcessHandle : THandle;
begin

   DreemSeeker_PID := GetProcessId('dreamseeker.exe');

   ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS,False, DreemSeeker_PID);
   if ProcessHandle > 0 then
    try
     ByondCore_dll_p := GetModuleBaseAddress(ProcessHandle, 'byondcore.dll');
    finally
     CloseHandle(ProcessHandle);
    end;

   if (DreemSeeker_PID > 0) and (ByondCore_dll_p <> nil) then begin
    SetAdrValue(DreemSeeker_PID, cardinal(byondcore_dll_p) + offset_horz_x, 4, tiles_horz); // X
    SetAdrValue(DreemSeeker_PID, cardinal(byondcore_dll_p) + offset_CNTR, 4, tiles_CNTR); // Center
    SetAdrValue(DreemSeeker_PID, cardinal(byondcore_dll_p) + offset_horz_y, 4, tiles_horz); // Y
    ShowMessage('Патч применен!');
   end else begin
    ShowMessage('Ошибка применения патча!');
   end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin

 Close;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin

  ShellExecute(Handle, 'open', PChar('https://money.yandex.ru/to/410013182793166'), 0, 0, SW_SHOWNORMAL);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  Label1.Caption := 'Версия: ' + version_STR;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  if GetProcessId('dreamseeker.exe') > 0 then begin
    Label3.Caption := 'Найдена';
    Label3.Font.Color := clGreen;
  end else begin
    Label3.Caption := 'Не найдена';
    Label3.Font.Color := clRed;
  end;

end;

end.
