import os
import re 

path = "images/2021_second"
files = os.listdir(path)

def transform_text(text):
    pattern = r"\((\d+)?([A-Z]?)\)"   # Pattern to match "(digits)(letter)"
    result = re.sub(pattern, r"_\1\2", text)  # Replace with "_digitsletter"
    return result

for index, file in enumerate(files):
    # print(transform_text(file))
    new_name = transform_text(file)
    os.rename(os.path.join(path, file), os.path.join(path, new_name))