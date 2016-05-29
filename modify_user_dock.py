import plistlib
import sys

if __name__ == "__main__":
  user = sys.argv[1]
  data = plistlib.readPlist("/Users/"+user+"/Library/Preferences/com.apple.dock.plist")
  data["persistent-others"] = []
  
  doc = {"tile-data":{"arrangement": 1,"displayas":0,"file-data":{"_CFURLString":"file:///Users/"+user+"/Documents","_CFURLStringType":15},"file-label":"My Documents","file-type":2,"showas":1},"tile-type":"directory-tile"}
  data["persistent-others"].append(doc)
  
  downloads = {"tile-data":{"arrangement": 2,"displayas":0,"file-data":{"_CFURLString":"file:///Users/"+user+"/Downloads","_CFURLStringType":15},"file-label":"My Downloads","file-type":2,"showas":1},"tile-type":"directory-tile"}
  data["persistent-others"].append(downloads)
  
  plistlib.writePlist(data,"/Users/"+user+"/Library/Preferences/com.apple.dock.plist")
