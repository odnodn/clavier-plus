﻿#ifdef IS_X64
#define Platform "x64"
#define PlatformName "64"
#else
#define Platform "Win32"
#define PlatformName "32"
#endif

#define RootDir "."
#define BinDir "."
#define CompilOutputDir "..\output\" + Platform + "_Release\"

#define AppName "Clavier+"
#define AppExeName "Clavier.exe"
#define InstallerFileName Copy(AppExeName, 1, RPos(".", AppExeName) - 1) + "Setup" + PlatformName
#define VersionFile AddBackslash(RootDir) + AddBackslash(BinDir) + CompilOutputDir + AppExeName

#define AppVersion GetFileProductVersion(VersionFile)
#define AppVerName AppName + " " + AppVersion
#define AppPublisher "Guillaume Ryder"
#define AppURL "http://utilfr42.free.fr"
#define HelpFileBaseUrl "http://utilfr42.free.fr/util/Clavier"

#define IniFile "Clavier.ini"

[Setup]
OutputDir=.
SourceDir={#RootDir}
ShowLanguageDialog=yes
OutputBaseFilename={#InstallerFileName}
AppName={#AppName}
AppVerName={#AppVerName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={localappdata}\{#AppName}
DefaultGroupName={#AppName}
VersionInfoVersion={#AppVersion}
VersionInfoCompany={#GetFileCompany(VersionFile)}
VersionInfoCopyright={#GetFileCopyright(VersionFile)}
Compression=lzma/ultra
SolidCompression=true
InternalCompressLevel=ultra
PrivilegesRequired=none
#ifdef IS_X64
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
#endif

[Languages]
Name: english; MessagesFile: compiler:Default.isl
Name: french; MessagesFile: compiler:Languages\French.isl
Name: german; MessagesFile: compiler:Languages\German.isl
Name: portuguese; MessagesFile: compiler:Languages\BrazilianPortuguese.isl
Name: russian; MessagesFile: compiler:Languages\Russian.isl

[Files]
Source: {#BinDir}\{#CompilOutputDir}{#AppExeName}; DestDir: {app}; Flags: ignoreversion
Source: {#BinDir}\ClavierEnglish.ini; DestDir: {app}; Flags: ignoreversion onlyifdoesntexist; DestName: {#IniFile}; Languages: english german
Source: {#BinDir}\ClavierFrench.ini; DestDir: {app}; Flags: ignoreversion onlyifdoesntexist; DestName: {#IniFile}; Languages: french
Source: {#BinDir}\ClavierGerman.ini; DestDir: {app}; Flags: ignoreversion onlyifdoesntexist; DestName: {#IniFile}; Languages: german
Source: {#BinDir}\ClavierPortuguese.ini; DestDir: {app}; Flags: ignoreversion onlyifdoesntexist; DestName: {#IniFile}; Languages: portuguese
Source: {#BinDir}\ClavierRussian.ini; DestDir: {app}; Flags: ignoreversion onlyifdoesntexist; DestName: {#IniFile}; Languages: russian

[Icons]
Name: {group}\{#AppName}; Filename: {app}\{#AppExeName}
Name: {group}\Help; Filename: {#HelpFileBaseUrl}Help.html; Languages: english
Name: {group}\Aide; Filename: {#HelpFileBaseUrl}Aide.html; Languages: french
Name: {group}\Hilfe; Filename: {#HelpFileBaseUrl}Hilfe.html; Languages: german
Name: {group}\Ajuda; Filename: {#HelpFileBaseUrl}Ajuda.html; Languages: portuguese
Name: {group}\Помощь; Filename: {#HelpFileBaseUrl}HelpRU.html; Languages: russian
Name: {group}\{cm:ProgramOnTheWeb,{#AppName}}; Filename: {#AppURL}
Name: {group}\{cm:UninstallProgram,{#AppName}}; Filename: {uninstallexe}

[Registry]
Root: HKCU; Subkey: Software\Microsoft\Windows\CurrentVersion\Run; ValueType: string; ValueName: {#AppName}; ValueData: {app}\{#AppExeName}; Flags: uninsdeletevalue

[Run]
Filename: {app}\{#AppExeName}; Description: {cm:LaunchProgram,{#AppName}}; Flags: postinstall skipifsilent nowait

[_ISTool]
UseAbsolutePaths=false

[Code]
// Close Clavier+ just before install
// Display Clavier+ settings just after install
procedure CurStepChanged(CurStep: TSetupStep);
begin
	if CurStep = ssInstall then
	begin
		PostBroadcastMessage(RegisterWindowMessage('RyderClavierOptions'), 1, 0);
		Sleep(1000)
	end
	else if CurStep = ssDone then
	begin
		Sleep(200);
		PostBroadcastMessage(RegisterWindowMessage('RyderClavierOptions'), 0, $201)
	end
end;

// Close Clavier+ just before uninstall
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
	if CurUninstallStep = usUninstall then
	begin
		PostBroadcastMessage(RegisterWindowMessage('RyderClavierOptions'), 1, 0)
		Sleep(1000);
	end
end;
