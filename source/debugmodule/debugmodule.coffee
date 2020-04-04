debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    adminmodule: true
    # configmodule: true
    mustachekeysmodule: true
    templatepreparationmodule: true


export default debugmodule
