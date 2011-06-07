function initXmlHttp() {
  /* Candidate Active X types for IE.*/
  var activeXTypes = [
    "MSXML2.XMLHTTP.5.0", "MSXML2.XMLHTTP.4.0", "MSXML2.XMLHTTP.3.0",
    "MSXML2.XMLHTTP", "MICROSOFT.XMLHTTP.1.0", "MICROSOFT.XMLHTTP.1",
    "MICROSOFT.XMLHTTP" ];
  var winner = null;

  if (typeof XMLHttpRequest == 'undefined' &&
      typeof ActiveXObject != 'undefined') {
    for (var i = 0; i < activeXTypes.length; i++) {
      var candidate = activeXTypes[i];
      try {
        new ActiveXObject(candidate);
        /* If the creation above does not cause exception, */
        /* record the candidate and return. */
        winner = candidate;
        break;
      } catch (e) {
        /* Do nothing; try next choice. */
      }
    }

    if (winner != null) {
      return new ActiveXObject(winner);
    }
  }

  /* Reaching point means xmlhttp initialization for IE failed. */
  if (typeof XMLHttpRequest != 'undefined') {
    return new XMLHttpRequest();
  }

  /* If all fail, return null. */
  return null;
}

/* Help function that returns the a specified field from a specified form. */
/* Null if not found. */
function getFieldFromForm(formName, fieldName) {

  if (formName == null || fieldName == null) {
    return null;
  }
  if (document.forms[formName] != null) {
    return document.forms[formName].elements[fieldName];
  }
  return null;
}
