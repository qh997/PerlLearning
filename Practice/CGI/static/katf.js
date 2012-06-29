window.onload = function() {
    ajax_load_platform();
    ajax_load_category();
}

function ajax_load_platform() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();
    }
    catch(e) {
        try{
            xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    xmlHttp.onreadystatechange = function() {
        if(xmlHttp.readyState == 4) {
            
            document.getElementsByName("platform")[0].options.length = 0;
            
            var platform = xmlHttp.responseText.split(",");
            
            for(i=0; i<platform.length; i++){
                if(platform[i] != ''){
                    var varItem = new Option(platform[i], platform[i]);
                    document.getElementsByName("platform")[0].options.add(varItem);
                }
            }
            
            for(j=0; j<document.getElementsByName("platform")[0].options.length; j++) {
                var selectedvalues = document.getElementsByName("platform")[0].options[j].value;
                
                selectedvalues = selectedvalues.replace("\n","");
                if(selectedvalues == getPlatformCookie()) {
                    document.getElementsByName("platform")[0].options[j].selected = true;
                }
                else{
                    document.getElementsByName("platform")[0].options[j].selected = false;
                }
            }

            platform_changed();
        }
    }

    xmlHttp.open("Get", "/perl/get_platform_list.cgi", true);
    xmlHttp.send(null);
}

function ajax_load_buildnumber() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();
    }
    catch(e) {
        try {
             xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    xmlHttp.onreadystatechange = function() {
        if(xmlHttp.readyState == 4) {
            
            document.getElementsByName("build_number")[0].options.length = 0;
            var buildnum = xmlHttp.responseText.split(",");
            
            for(i=0; i<buildnum.length; i++) {
                if(buildnum[i]!='') {
                    var varItem = new Option(buildnum[i], buildnum[i]);
                    document.getElementsByName("build_number")[0].options.add(varItem);
                }
            }
            
            for(j=0; j<document.getElementsByName("build_number")[0].options.length; j++) {
                var selectedvalues = document.getElementsByName("build_number")[0].options[j].value;
                
                selectedvalues = selectedvalues.replace("\n","");
                if(selectedvalues == getBuildNumCookie()) {
                    document.getElementsByName("build_number")[0].options[j].selected = true;
                }
                else{
                    document.getElementsByName("build_number")[0].options[j].selected = false;
                }
            }

            buildnumber_changed();
        }
    }

    var currSelectValue = document.getElementsByName("platform")[0].value;
    xmlHttp.open("Get","/perl/get_buildnumber_list.cgi?platform="+currSelectValue,true);
    xmlHttp.send(null);
}

function ajax_load_category() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();
    }
    catch(e) {
        try{
            xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    xmlHttp.onreadystatechange = function() {
        if(xmlHttp.readyState == 4) {
            
            document.getElementsByName("category")[0].options.length = 0;
            
            var category = xmlHttp.responseText.split(",");
            
            for(i=0; i<category.length; i++){
                if(category[i] != ''){
                    var varItem = new Option(category[i], category[i]);
                    document.getElementsByName("category")[0].options.add(varItem);
                }
            }
            
            for(j=0; j<document.getElementsByName("category")[0].options.length; j++) {
                var selectedvalues = document.getElementsByName("category")[0].options[j].value;
                
                selectedvalues = selectedvalues.replace("\n","");
                if(selectedvalues == getCategoryCookie()) {
                    document.getElementsByName("category")[0].options[j].selected = true;
                }
                else {
                    document.getElementsByName("category")[0].options[j].selected = false;
                }
            }
        }
    }

    xmlHttp.open("Get", "/perl/get_category_list.cgi", true);
    xmlHttp.send(null);
}

function ajax_load_testcase() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();
    }
    catch(e) {
        try {
             xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

    xmlHttp.onreadystatechange = function() {
        if(xmlHttp.readyState == 4) {
            
            document.getElementsByName("testcases")[0].options.length = 0;
            var buildnum = xmlHttp.responseText.split(",");
            for(i=0; i<buildnum.length; i++) {
                if(buildnum[i]!='') {
                    var varItem = new Option(buildnum[i], buildnum[i]);
                    document.getElementsByName("testcases")[0].options.add(varItem);
                }
            }
            
            for(j=0; j<document.getElementsByName("testcases")[0].options.length; j++) {
                var selectedvalues = document.getElementsByName("testcases")[0].options[j].value;
                
                selectedvalues = selectedvalues.replace("\n","");
                if(selectedvalues == getTestcaseCookie()) {
                    document.getElementsByName("testcases")[0].options[j].selected = true;
                }
                else {
                    document.getElementsByName("testcases")[0].options[j].selected = false;
                }
            }
        }
    }

    var currplatform = document.getElementsByName("platform")[0].value;
    var currbuildnum = document.getElementsByName("build_number")[0].value;
    var currcategory = document.getElementsByName("category")[0].value;
    xmlHttp.open("Get", "/perl/get_testcase_list.cgi?platform="+currplatform+"&buildnum="+currbuildnum+"&category="+currcategory,true);
    xmlHttp.send(null);
}

function platform_changed() {
    setPlatformCookie();
    ajax_load_buildnumber();
}

function buildnumber_changed() {
    setBuildNumCookie();
    ajax_load_testcase();
}

function category_changed() {
    setCategoryCookie();
    ajax_load_testcase();
}

function testcase_changed() {
    setTestcaseCookie();
}

function getPlatformCookie() {
    var strcookie = document.cookie;
    var arrcookie = strcookie.split("; ");
    for(var i=0; i<arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if(arr[0] == "platform") {
            return arr[1].replace(/%0A/,"");
        }
    }
    return "";
}

function setPlatformCookie() {
    var cookieString = "platform="+escape(document.getElementsByName("platform")[0].value.replace(/%0A/,""));
    var date = new Date();
    date.setTime(date.getTime+1*3600*1000);
    cookieString = cookieString+"; expire="+date.toGMTString();
    document.cookie = cookieString;
}

function getBuildNumCookie() {
    var strcookie = document.cookie;
    var arrcookie = strcookie.split("; ");
    for(var i=0; i<arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if(arr[0] == "buildnum") {
            return arr[1].replace(/%0A/,"");
        }
    }
    return "";
}

function setBuildNumCookie() {
    var cookieString = "buildnum="+escape(document.getElementsByName("build_number")[0].value.replace(/%0A/,""));
    var date = new Date();
    date.setTime(date.getTime+1*3600*1000);
    cookieString = cookieString+"; expire="+date.toGMTString();
    document.cookie = cookieString;
}

function getCategoryCookie() {
    var strcookie = document.cookie;
    var arrcookie = strcookie.split("; ");
    for(var i=0; i<arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if(arr[0] == "category") {
            return arr[1].replace(/%0A/,"");
        }
    }
    return "";
}

function setCategoryCookie() {
    var cookieString = "category="+escape(document.getElementsByName("category")[0].value.replace(/%0A/,""));
    var date = new Date();
    date.setTime(date.getTime+1*3600*1000);
    cookieString = cookieString+"; expire="+date.toGMTString();
    document.cookie = cookieString;
}

function getTestcaseCookie() {
    var strcookie = document.cookie;
    var arrcookie = strcookie.split("; ");
    for(var i=0; i<arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if(arr[0] == "testcase") {
            return arr[1].replace(/%0A/,"");
        }
    }
    return "";
}

function setTestcaseCookie() {
    var cookieString = "testcase="+escape(document.getElementsByName("testcases")[0].value.replace(/%0A/,""));
    var date = new Date();
    date.setTime(date.getTime+1*3600*1000);
    cookieString = cookieString+"; expire="+date.toGMTString();
    document.cookie = cookieString;
}