# robot -d results -i Smoke  process_practice.robot
from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import _Misc, BuiltIn 
import subprocess

@library
class python_tag_class:

    # def __init__(self, returnCode):
    #     self.returnCode = returnCode
    #     self.selLib = BuiltIn().get_library_instance("smoke.py")

    @keyword
    def launch_py_tags_test(self, tag_name, path_tests_file):
        command = f'robot -d results -i {tag_name} {path_tests_file}'
        process = subprocess.Popen(command, shell=True)
        process.communicate()
        return process.returncode
