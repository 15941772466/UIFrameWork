local Logger = {}

Logger.log = function(msg)
    CS.UnityEngine.Debug.Log(msg)
end

Logger.logWarning = function(msg)
    CS.UnityEngine.Debug.LogWarning(msg)
end

Logger.logError = function(msg)
    CS.UnityEngine.Debug.LogError(msg)
end

return Logger