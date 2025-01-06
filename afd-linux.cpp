#include <iostream>
#include <filesystem>

using namespace std;


int main(int argc, char* argv[]) {

    if(argc < 2) {
        cerr << "File name is not specified" << endl;
        return EXIT_FAILURE;
    }

    if (system("cp ~/afd.exe .") && !filesystem::exists(filesystem::path("./afd.exe"))) {
        cerr << "Could Not Copy AFD!" << endl;
        return EXIT_FAILURE;
    }

    // TODO: Check if file exists
    // TODO: Check if filename is smaller than 8 characters (AFD is dumb shit)
    char* name = argv[1];
    string nameStr(name);

    string command1 = "nasm "  + nameStr + ".asm -l " + nameStr + ".lst -o " + nameStr + ".com";
    if (system(command1.c_str())) {
        cerr << "NASM Could not compile the assembly!" << endl;
        return EXIT_FAILURE;
    }

    system("pwd");
    string command2 = "dosbox -c \"mount C .\" -c \"C:\" -c \"afd " + nameStr + ".com\"";
    if (system(command2.c_str())) {
        cerr << "DOSBOX Failed to run" << endl;
        return EXIT_FAILURE;
    }

    return 0;
}
