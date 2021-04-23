def GetIn(data, key):
    # early exit if called with missing key
    if data == None:
        return data

    # if key has more than one value, get first value from data and recurse
    keys = key.split("/")
    if len(keys) > 1:
        data = data.get(keys[0])
        del keys[0]
        return GetIn(data, "/".join(keys))
    else:
        # otherwise return desired key
        return data.get(keys[0])