# Produce assembly from C code for various compiler
# Compiler support:
#   - GCC         (GNU Compiler Collection)
#   - MSVC        (Visual Studio C++)
#   - Clang       (LLVM Clang)
#   - C++ Builder (RAD Studio XE8)
import os
import sys 

### Configuration
# Path
GCC_PATH   = "D:/TDM-GCC-64/bin/gcc.exe"
MSVC_PATH  = "cl.exe"
CLANG_PATH = "D:/LLVM/bin/clang.exe"
BCC_PATH   = "D:/Embarcadero/Studio/16.0/bin/bcc{}.exe"


### Base class 
class Compiler:    
    def __init__(self, id, compiler_path):
        self.compiler_path = compiler_path
        self.csrc = "src"
        self.asmdst = id
    
    def assemble(self, filename):
        self.filename = filename 

        print("Using ({})".format(self.asmdst))
        commands = self.build()
        for arch, command in commands:
            print("   Compiling ({}): {}".format(arch, command))
            os.system(command)
        self.cleanup()
    
    # Build for all architecture supported
    def build(self):
        pass 
    
    def cleanup(self):
        print("({}) done ...".format(self.asmdst)) 
        print("=======================\n")

### GNU Compiler Collection 
class Gcc(Compiler):    
    def build(self):
        commands = []
        commands.append(("x86/intel", "{0}      -S -masm=intel {1}/{3}.c -o {2}/x86/intel/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x64/intel", "{0} -m32 -S -masm=intel {1}/{3}.c -o {2}/x64/intel/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x86/att",   "{0}      -S {1}/{3}.c -o {2}/x86/att/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x64/att",   "{0} -m32 -S {1}/{3}.c -o {2}/x64/att/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        return commands


### Visual C++ (Visual Studio)
class Msvc(Compiler):
    def assemble(self, filename):
        self.filename = filename

        envvars = os.environ
        self.__set_common_env()
        print("Using ({})".format(self.asmdst))
        for i in ['64','32']:
            self.environment(i)
            arch, command = self.build(i)
            print("   Compiling ({}): {}".format(arch, command))
            os.system(command)

        os.environ = envvars
        self.cleanup()

    # Configure some environment
    def __set_common_env(self):
        envs = {
            "DevEnvDir" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\",
            "ExtensionSdkDir" : "C:\\Program Files (x86)\\Microsoft SDKs\\Windows Kits\\10\\ExtensionSDKs",
            "Framework40Version" : "v4.0",
            "FrameworkDir" : "C:\\WINDOWS\\Microsoft.NET\\Framework64\\",
            "UCRTVersion" : "10.0.15063.0",
            "UniversalCRTSdkDir" : "C:\\Program Files (x86)\\Windows Kits\\10\\",
            "VCIDEInstallDir" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\VC\\",
            "VCINSTALLDIR" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\",
            "VCToolsInstallDir" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\",
            "VCToolsRedistDir" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Redist\\MSVC\\14.10.25017\\",
            "VisualStudioVersion" : "15.0",
            "VS150COMNTOOLS" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\Tools\\",
            "VSCMD_ARG_app_plat" : "Desktop",
            "VSCMD_VER" : "15.0.26430.16",
            "VSINSTALLDIR" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\",
            "WindowsLibPath" : "C:\\Program Files (x86)\\Windows Kits\\10\\UnionMetadata\\10.0.15063.0\\;C:\\Program Files (x86)\\Windows Kits\\10\\References\\10.0.15063.0\\",
            "WindowsSdkBinPath" : "C:\\Program Files (x86)\\Windows Kits\\10\\bin\\",
            "WindowsSdkDir" : "C:\\Program Files (x86)\\Windows Kits\\10\\",
            "WindowsSDKLibVersion" : "10.0.15063.0\\",
            "WindowsSdkVerBinPath" : "C:\\Program Files (x86)\\Windows Kits\\10\\bin\\10.0.15063.0\\",
            "WindowsSDKVersion" : "10.0.15063.0\\",
            "WindowsSDK_ExecutablePath_x64" : "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v10.0A\\bin\\NETFX 4.6.1 Tools\\x64\\",
            "WindowsSDK_ExecutablePath_x86" : "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v10.0A\\bin\\NETFX 4.6.1 Tools\\",
            "FrameworkVersion32" : "v4.0.30319"
        }

        for key in envs.keys():
            os.environ[key] = envs[key]

        
    def environment(self, i):
        if i == '32':
            envs = {
                "LIB" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\ATLMFC\\lib\\x64;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\lib\\x64;C:\\Program Files (x86)\\Windows Kits\\NETFXSDK\\4.6.1\\lib\\um\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.15063.0\\ucrt\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.15063.0\\um\\x64;",
                "LIBPATH" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\ATLMFC\\lib\\x64;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\lib\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\UnionMetadata\\10.0.15063.0\\;C:\\Program Files (x86)\\Windows Kits\\10\\References\\10.0.15063.0\\;C:\\WINDOWS\\Microsoft.NET\\Framework64\\v4.0.30319;",
                "Path" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\bin\\HostX64\\x64;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\VC\\VCPackages;C:\\Program Files (x86)\\Microsoft SDKs\\TypeScript\\2.2;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\TestWindow;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\TeamFoundation\\Team Explorer;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\MSBuild\\15.0\\bin\\Roslyn;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Team Tools\\Performance Tools;C:\\Program Files (x86)\\Microsoft Visual Studio\\Shared\\Common\\VSPerfCollectionTools\\;C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v10.0A\\bin\\NETFX 4.6.1 Tools\\;C:\\Program Files (x86)\\Windows Kits\\10\\bin\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\bin\\10.0.15063.0\\x64;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\\\MSBuild\\15.0\\bin;C:\\WINDOWS\\Microsoft.NET\\Framework64\\v4.0.30319;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\Tools\\;D:\\Embarcadero\\Studio\\16.0\\bin;C:\\Users\\Public\\Documents\\Embarcadero\\Studio\\16.0\\Bpl;D:\\Embarcadero\\Studio\\16.0\\bin64;C:\\Users\\Public\\Documents\\Embarcadero\\Studio\\16.0\\Bpl\\Win64;C:\\ProgramData\\Oracle\\Java\\javapath;D:\\Python36\\Scripts\\;D:\\Python36\\;D:\\Python27\\Scripts\\;D:\\Python27\\;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;D:\\TDM-GCC-64\\bin;C:\\Program Files (x86)\\NVIDIA Corporation\\PhysX\\Common;D:\\LLVM\\bin;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;D:\\Go\\bin;D:\\CMake\\bin;D:\\Z3;D:\\Rust stable MSVC 1.15\\bin;D:\\NASM;D:\\android\\sdk\\platform-tools;D:\\Java\\jdk1.8.0_144\\bin;C:\\Program Files (x86)\\Windows Kits\\8.1\\Windows Performance Toolkit\\;C:\\Users\\xathrya\\AppData\\Local\\Microsoft\\WindowsApps;;D:\\Microsoft VS Code\\bin",
                "Platform" : "x64",
                "VSCMD_ARG_HOST_ARCH" : "x64",
                "VSCMD_ARG_TGT_ARCH" : "x64",
            }
        else:
            envs = {
                "LIB" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\ATLMFC\\lib\\x86;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\lib\\x86;C:\\Program Files (x86)\\Windows Kits\\NETFXSDK\\4.6.1\\lib\\um\\x86;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.15063.0\\ucrt\\x86;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.15063.0\\um\\x86;",
                "LIBPATH" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\ATLMFC\\lib\\x86;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\lib\\x86;C:\\Program Files (x86)\\Windows Kits\\10\\UnionMetadata\\10.0.15063.0\\;C:\\Program Files (x86)\\Windows Kits\\10\\References\\10.0.15063.0\\;C:\\WINDOWS\\Microsoft.NET\\Framework\\v4.0.30319;",
                "Path" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.10.25017\\bin\\HostX86\\x86;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\VC\\VCPackages;C:\\Program Files (x86)\\Microsoft SDKs\\TypeScript\\2.2;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\TestWindow;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\TeamFoundation\\Team Explorer;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\MSBuild\\15.0\\bin\\Roslyn;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Team Tools\\Performance Tools;C:\\Program Files (x86)\\Microsoft Visual Studio\\Shared\\Common\\VSPerfCollectionTools\\;C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v10.0A\\bin\\NETFX 4.6.1 Tools\\;C:\\Program Files (x86)\\Windows Kits\\10\\bin\\x86;C:\\Program Files (x86)\\Windows Kits\\10\\bin\\10.0.15063.0\\x86;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\\\MSBuild\\15.0\\bin;C:\\WINDOWS\\Microsoft.NET\\Framework\\v4.0.30319;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\Tools\\;D:\\Embarcadero\\Studio\\16.0\\bin;C:\\Users\\Public\\Documents\\Embarcadero\\Studio\\16.0\\Bpl;D:\\Embarcadero\\Studio\\16.0\\bin64;C:\\Users\\Public\\Documents\\Embarcadero\\Studio\\16.0\\Bpl\\Win64;C:\\ProgramData\\Oracle\\Java\\javapath;D:\\Python36\\Scripts\\;D:\\Python36\\;D:\\Python27\\Scripts\\;D:\\Python27\\;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;D:\\TDM-GCC-64\\bin;C:\\Program Files (x86)\\NVIDIA Corporation\\PhysX\\Common;D:\\LLVM\\bin;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;D:\\Go\\bin;D:\\CMake\\bin;D:\\Z3;D:\\Rust stable MSVC 1.15\\bin;D:\\NASM;D:\\android\\sdk\\platform-tools;D:\\Java\\jdk1.8.0_144\\bin;C:\\Program Files (x86)\\Windows Kits\\8.1\\Windows Performance Toolkit\\;C:\\Users\\xathrya\\AppData\\Local\\Microsoft\\WindowsApps;;D:\\Microsoft VS Code\\bin",
                "Platform" : "x86",
                "VSCMD_ARG_HOST_ARCH" : "x86",
                "VSCMD_ARG_TGT_ARCH" : "x86",
            }
        
        for key in envs.keys():
            os.environ[key] = envs[key]


    def build(self, env):
        arch = "x64" if env == "64" else "x86"
        return (arch, "\"{0}\" /nologo /Fa{2}/{4}/{3}.asm /c {1}/{3}.c".format(self.compiler_path, self.csrc, self.asmdst, self.filename, arch))
        
    def cleanup(self):
        os.remove("{}.obj".format(self.filename))
        print("({}) done ...".format(self.asmdst)) 
        print("=======================\n")


### LLVM Clang
class Clang(Compiler):
    def build(self):
        commands = []
        commands.append(("x86/intel", "{0}      -S -masm=intel {1}/{3}.c -o {2}/x86/intel/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x64/intel", "{0} -m32 -S -masm=intel {1}/{3}.c -o {2}/x64/intel/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x86/att",   "{0}      -S {1}/{3}.c -o {2}/x86/att/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        commands.append(("x64/att",   "{0} -m32 -S {1}/{3}.c -o {2}/x64/att/{3}.asm".format(self.compiler_path, self.csrc, self.asmdst, self.filename)))
        return commands


### C++ Builder (RAD Studio XE8)
class CBuilder(Compiler):
    def build(self):
        commands = []
        commands.append(("x64", "{0} -S -o {2}/x64/{3}.asm {1}/{3}.c ".format(self.compiler_path.format("64"), self.csrc, self.asmdst, self.filename)))
        commands.append(("x32", "{0} -S -o {2}/x86/{3}.asm {1}/{3}.c ".format(self.compiler_path.format("32"), self.csrc, self.asmdst, self.filename)))
        return commands

if __name__ == '__main__':
    compilers = [ ]
    compilers.append(Gcc("gcc", GCC_PATH))
    compilers.append(Msvc("msvc", MSVC_PATH))
    compilers.append(Clang("clang", CLANG_PATH))
    compilers.append(CBuilder("cbuilder", BCC_PATH))

    if len(sys.argv) < 2:
        while True:
            filename = input(">> ")

            for compiler in compilers:
                compiler.assemble(filename)
    else:
        filename = sys.argv[1]

        for compiler in compilers:
            compiler.assemble(filename)