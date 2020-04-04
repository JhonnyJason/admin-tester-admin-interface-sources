indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.adminPanel = document.getElementById("admin-panel")
    global.secretInput = document.getElementById("secret-input")
    global.loginButton = document.getElementById("login-button")
    global.discardButton = document.getElementById("discard-button")
    global.publishButton = document.getElementById("publish-button")
    global.showEditablesButton = document.getElementById("show-editables-button")
    global.panelVisibilityButton = document.getElementById("panel-visibility-button")
    return
    
module.exports = indexdomconnect