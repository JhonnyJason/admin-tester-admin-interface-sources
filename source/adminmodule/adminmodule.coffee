adminmodule = {name: "adminmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if adminModules.debugmodule.modulesToDebug["adminmodule"]?  then console.log "[adminmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

mustache = require "mustache"

############################################################
mustachekeys = null
templatepreparation = null

############################################################
currentEditTextFallback = ""

typingSecret = false
loggingIn = false
token =  ""
panelVisible =  true
showingEditables = false

############################################################
adminmodule.initialize = () ->
    log "adminmodule.initialize"
    mustachekeys = adminModules.mustachekeysmodule
    templatepreparation = adminModules.templatepreparationmodule
    
    adminPanel.addEventListener("load", adminPanelLoaded)
    panelVisibilityButton.addEventListener("click", panelVisibilityButtonClicked) 

    loginButton.addEventListener("click", loginButtonClicked)
    discardButton.addEventListener("click", discardButtonClicked)

    publishButton.addEventListener("click", publishButtonClicked)
    showEditablesButton.addEventListener("click", showEditablesButtonClicked)
    secretInput.addEventListener("keydown", secretKeyPress)
    return

############################################################
#region adminPanelEventListeners
secretKeyPress = ->
    log "secretKeyPress"
    ##TODO implement
    return

showEditablesButtonClicked = ->
    log "showEditablesButtonClicked"
    ##TODO implement
    return

publishButtonClicked = ->
    log "publishButtonClicked"
    ##TODO implement
    return

discardButtonClicked = ->
    log "discardButtonClicked"
    ##TODO implement
    return

loginButtonClicked = ->
    log "loginButtonClicked"
    if (typingSecret) then sendLoginRequest()
    else
        typingSecret = true
        applyStateTypingSecret()
        saveAppState()
    return


panelVisibilityButtonClicked = -> #togglePanelVisibility
    log "panelVisibilityButtonClicked"
    if(panelVisible) then panelVisible = false
    else panelVisible = true

    applyStatePanel()
    saveAppState()
    return

adminPanelLoaded = ->
    log "adminPanelLoaded"
    return

#endregion

############################################################
#region appStateStuff
applyStatePanel = ->
    log "applyStatePanel"
    if panelVisible
        adminPanel.classList.remove("hidden")
        panelVisibilityButton.classList.remove("hidden-panel")
    else
        adminPanel.classList.add("hidden")
        panelVisibilityButton.classList.add("hidden-panel")
    return

applyStateTypingSecret = ->
    log "applyStateTypingSecret"
    if(typingSecret)
        secretInput.style.display = "inline-block"
        loginButton.textContent = "Einloggen"
    else 
        loginButton.style.display = "inline-block"
        loginButton.textContent = "Zum Login"
        secretInput.style.display = "none"
        secretInput.value = ""
    return

saveAppState = ->
    log "saveAppState"
    ##TODO implement
    return

#endregion

############################################################
#region requestFunctions
sendLoginRequest = ->
    log "sendLoginRequest"
    ##TODO implement
    return

#endregion

############################################################
#region stuffForEditing
addAdministrativeEventListeners = ->
    log "addAdministrativeEventListeners"
    editables = document.querySelectorAll("[contentEditable]")
    for editable in editables
        editable.addEventListener("keydown", editKeyPressed)
        editable.addEventListener("focusin", startedEditing)
        editable.addEventListener("focusout", stoppedEditing)
    return

editKeyPressed = (event) ->
    log "editKeyPressed"
    key = event.keyCode
    if (key == 27) #escape
        this.textContent = currentEditTextFallback
        document.activeElement.blur()
    return

startedEditing = (event) ->
    log "startedEditing"
    element = event.target
    element.classList.add("editing")
    currentEditTextFallback = element.textContent
    return

stoppedEditing = (event) ->
    log "stoppedEditing"
    element = event.target
    element.classList.remove("editing")
    contentKeyString = element.getAttribute("text-content-key")
    newContentText(contentKeyString, element.textContent)
    return

newContentText = (contentKeyString, text) ->
    log "newContentText"
    log contentKeyString
    log text
    return

#endregion

renderProcess = ->
    log "renderProcess"
    mustachekeys.createMustacheKeys()
    mustacheTemplate = template(pwaMustacheKeymap)
    
    log mustacheTemplate
    shadowBody = document.createElement("body")
    shadowBody.innerHTML = mustacheTemplate
    templatepreparation.prepareBody(shadowBody)

    preparedTemplate = shadowBody.innerHTML
    log preparedTemplate

    htmlResult = mustache.render(preparedTemplate, pwaContent)
    log htmlResult

    newBody = document.createElement("body")
    newBody.innerHTML = htmlResult
    newBody.append adminPanel
    newBody.append panelVisibilityButton
    document.body = newBody
    # document.body.parentElement.replaceNode(newBody, oldBody)
    # olog pwaContent
    # olog pwaMustacheKeymap
    addAdministrativeEventListeners()
    return

############################################################
adminmodule.start = ->
    log "adminmodule.start"
    renderProcess()
    return


module.exports = adminmodule