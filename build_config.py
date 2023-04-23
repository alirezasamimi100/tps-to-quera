import json

# open files
mp = {}
with open("mapping") as mi:
    for line in mi:
        s, x = line.strip().split()
        if s not in mp:
            mp[s] = []
        mp[s].append(int(x))

with open("subtasks.json") as js:
    subs = json.load(js)

# create config.json file
qu = {}
qu["packages"] = []
for key, value in subs["subtasks"].items():
    qu["packages"].append({"score": value["score"], "tests": mp[key]})

with open("config.json", "w") as qj:
    json.dump(qu, qj, indent=4)
