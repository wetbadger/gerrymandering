# PUZZLE COMPILER
# Compiles JSON files into gd script variables

import os
import json

def json_to_dict(json_string):
    try:
        # Convert JSON string to dictionary
        dictionary = json.loads(json_string)
        return dictionary
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        print(json_string)
        return None
    
def dict_to_json(dictionary):
    try:
        # Convert dictionary to JSON string
        json_string = json.dumps(dictionary, indent=4)
        return json_string
    except TypeError as e:
        print(f"Error encoding JSON: {e}")
        return None

if __name__ == "__main__":
    path = "Puzzles"
    contents = os.listdir(path=path)
    directories = [item for item in contents if os.path.isdir(os.path.join(path, item))]

    for dir in directories:
        matrix = ""
        terrain = ""
        settings = ""
        is_terrain = False
        with open(path+"/"+dir+"/matrix.json", "r") as f:
            matrix = f.read() + "\n"
        with open(path+"/"+dir+"/settings.json", "r") as f:
            settings = f.read() + "\n"
        try:
            with open(path+"/"+dir+"/terrain.json", "r") as f:
                terrain = f.read() + "\n"
                is_terrain = True
        except FileNotFoundError:
            pass

        settings_dict = json_to_dict(settings)
        #set layout to random and algorithm to load_from_file
        settings_dict["advanced"]["House Placement"]["layout"] = "random"
        settings_dict["advanced"]["House Placement"]["algorithm"] = "load from file"
        #disable save
        settings_dict["disable_save"] = True

        settings = dict_to_json(settings_dict)

        with open(path+"/"+dir+"/map.tres", "w+") as f:
            
            f.write("""
[gd_resource type="Resource" load_steps=2 format=2]

[ext_resource path="res://Puzzles/map.gd" type="Script" id=1]

[resource]
script = ExtResource( 1 )            
""")
            #f.write(matrix + terrain + settings)
            
            f.write("settings = "+str(settings)+"\n")
            f.write("matrix = "+str(matrix)+"\n")
            if is_terrain:
                f.write("terrain = "+str(terrain)+"\n")
            else:
                f.write("terrain = {}\n")
