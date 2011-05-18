(function() {
    var f = null,
    aa = this,
    g = function(a, b) {
        var d = a.split("."),
        c = aa; ! (d[0] in c) && c.execScript && c.execScript("var " + d[0]);
        for (var e; d.length && (e = d.shift());) ! d.length && b !== void 0 ? c[e] = b: c = c[e] ? c[e] : c[e] = {}
    };
    function h(a, b, d) {
        var c = "on" + b;
        if (a.addEventListener) a.addEventListener(b, d, !1);
        else if (a.attachEvent) a.attachEvent(c, d);
        else {
            var e = a[c];
            a[c] = function() {
                var a = e.apply(this, arguments),
                b = d.apply(this, arguments);
                return a == void 0 ? b: b == void 0 ? a: b && a
            }
        }
    };
    var j = !0,
    ba, k, l, n, o = "",
    p, q = f,
    r = f,
    s = f,
    t = -1,
    u, v, w, x, y = f,
    z = f,
    B, C, D = f,
    E, ca = "suggestqueries.google.com",
    F = 0,
    G = 0,
    H = 0,
    I = f,
    J, K = !1,
    L = !1,
    M, N, da, O = navigator.userAgent.toLowerCase();
    M = O.indexOf("opera") != -1;
    N = O.indexOf("msie") != -1 && !M;
    da = O.indexOf("webkit") != -1;
    var P = f,
    ha = RegExp("^[\\s\\u1100-\\u11FF\\u3040-\\u30FF\\u3130-\\u318F\\u31F0-\\u31FF\\u3400-\\u4DBF\\u4E00-\\u9FFF\\uAC00-\\uD7A3\\uF900-\\uFAFF\\uFF65-\\uFFDC]+$"),
    ia = !0;
    function ja(a) {
        if (a.persisted) B.value = "f",
        C.value = v.value
    }
    function ka() {
        var a = document.body.dir == "rtl",
        b = a ? "right": "left",
        a = a ? "left": "right",
        d = document.getElementsByTagName("head")[0],
        c = document.createElement("style"),
        e = f,
        i = f,
        A = !1;
        document.styleSheets && (d.appendChild(c), A = !0, e = c.sheet ? c.sheet: c.styleSheet);
        e || (i = document.createTextNode(""), c.appendChild(i));
        var m = function(a, b) {
            var c = a + " { " + b + " }";
            e ? e.insertRule ? e.insertRule(c, e.cssRules.length) : e.addRule && e.addRule(a, b) : i.data += c + "\n"
        };
        m(".google-ac-m", "font-size:13px;font-family:arial,sans-serif;cursor:default;line-height:17px;border:1px solid black;z-index:99;position:absolute;background-color:white;margin:0;");
        m(".google-ac-a", "background-color:white;");
        m(".google-ac-b", "background-color:#36c;color:white;");
        m(".google-ac-c", "white-space:nowrap;overflow:hidden;text-align:" + b + ";padding-" + b + ":3px;" + (N || M ? "padding-bottom:1px;": ""));
        m(".google-ac-d", "white-space:nowrap;overflow:hidden;font-size:10px;text-align:" + a + ";color:green;padding-" + b + ":3px;padding-" + a + ":3px;");
        m(".google-ac-b td", "color:white;");
        m(".google-ac-e td", "padding:0 3px 2px;text-align:" + a + ";font-size:10px;line-height:15px;");
        m(".google-ac-e span", "color:blue;text-decoration:underline;cursor:pointer;");
        A || d.appendChild(c)
    }
    function Q() {
        if (w && (x.left = la("offsetLeft") + "px", x.top = la("offsetTop") + v.offsetHeight - 1 + "px", x.width = v.offsetWidth + "px", y)) z.left = x.left,
        z.top = x.top,
        z.width = w.offsetWidth + "px",
        z.height = w.offsetHeight + "px"
    }
    function R(a, b) {
        a.visibility = b ? "visible": "hidden"
    }
    function ma(a, b, d) {
        var c = document.createElement("input");
        c.type = "hidden";
        c.name = a;
        c.value = b;
        c.disabled = d;
        return u.appendChild(c)
    }
    function na() {
        K || S();
        K = !1
    }
    function oa() {
        if (K) window.event.cancelBubble = !0,
        window.event.returnValue = !1;
        K = !1
    }
    function T(a) {
        var b = a.keyCode;
        if (b == 27 && x.visibility == "visible") return S(),
        U(l),
        a.cancelBubble = !0,
        a.returnValue = !1;
        if (!V(b) && !W(b)) return ! 0;
        H++;
        H % 3 == 1 && X(b);
        return ! 1
    }
    function pa(a) {
        a = a.keyCode; (!J || !V(a) && !W(a)) && H == 0 && X(a);
        H = 0;
        return ! (V(a) || W(a))
    }
    function X(a) {
        if (J && (V(a) || W(a))) K = !0,
        v.blur(),
        window.setTimeout(Y, 10);
        if (v.value != k || a == 39) if (l = v.value, p = qa(), a != 39) C.value = l;
        W(a) ? sa(t + 1) : V(a) && sa(t - 1);
        Q();
        o != l && !I && (I = window.setTimeout(S, 500));
        k = v.value;
        k == "" && !q && Z()
    }
    function V(a) {
        return a == 38 || a == 63232
    }
    function W(a) {
        return a == 40 || a == 63233
    }
    function ta() {
        v.blur();
        B.value = this.a;
        U(this.b);
        ia ? ua() && u.submit() : S()
    }
    function va() {
        if (!L) {
            if (s) s.className = "google-ac-a";
            this.className = "google-ac-b";
            s = this;
            for (var a = 0; a < r.length; a++) if (r[a] == s) {
                t = a;
                break
            }
        }
    }
    function wa() {
        L && (L = !1, va.call(this))
    }
    function sa(a) {
        if (o == "" && l != "") n = "",
        Z();
        else if (l == o && q && r && !(r.length <= 0)) if (x.visibility == "visible") {
            var b = r.length;
            P && (b -= 1);
            if (s) s.className = "google-ac-a";
            a == b || a == -1 ? (t = -1, U(l), Y(), B.value = "f") : (a > b ? a = 0 : a < -1 && (a = b - 1), t = a, s = r.item(a), s.className = "google-ac-b", U(s.b), B.value = s.a)
        } else $()
    }
    function S() {
        I && (window.clearTimeout(I), I = f);
        R(x, !1);
        y && R(z, !1)
    }
    function $() {
        j && (R(x, !0), y && R(z, !0), Q(), L = !0)
    }
    function xa(a) {
        F > 0 && F--;
        if (a[0] == l) I && (window.clearTimeout(I), I = f),
        o = a[0],
        ya(a[1]),
        t = -1,
        r = w.rows,
        (r.length > 0 ? $: S)()
    }
    function ua() {
        S();
        C.disabled = !0;
        if (C.value != v.value) B.value = r.item(t).a,
        C.disabled = !1;
        else if (G >= 3 || F >= 10) B.value = "o";
        return ! 0
    }
    function Z() {
        if (!j) return ! 1;
        if (G >= 3) return ! 1;
        if (n != l && l) {
            var a = (encodeURIComponent || escape)(l);
            F++;
            if (ba) {
                var b = document.createElement("script");
                b.setAttribute("type", "text/javascript");
                b.setAttribute("charset", "utf-8");
                b.setAttribute("id", "jsonpACScriptTag");
                b.setAttribute("src", "//" + ca + E + "&jsonp=ac_hr&q=" + a + "&cp=" + p);
                var a = document.getElementById("jsonpACScriptTag"),
                d = document.getElementsByTagName("head")[0];
                a && d.removeChild(a);
                d.appendChild(b)
            } else za(a);
            Y()
        }
        n = l;
        b = 100;
        for (a = 1; a <= (F - 2) / 2; ++a) b *= 2;
        b += 50;
        q = window.setTimeout(Z, b);
        return ! 0
    }
    function U(a) {
        k = v.value = a
    }
    function Y() {
        v.focus()
    }
    function la(a) {
        for (var b = v,
        d = 0; b;) d += b[a],
        b = b.offsetParent;
        return d
    }
    function ya(a) {
        for (; w.rows.length > 0;) w.deleteRow( - 1);
        var b = 0,
        d;
        for (d in a) {
            var c = a[d];
            if (c) {
                b++;
                var e = w.insertRow( - 1);
                e.onclick = ta;
                e.onmousedown = Aa;
                e.onmouseover = va;
                e.onmousemove = wa;
                e.b = c[0];
                e.a = c[2];
                e.className = "google-ac-a";
                var i = document.createElement("td");
                i.appendChild(document.createTextNode(c[0]));
                i.className = "google-ac-c";
                if (N && ha.test(c[0])) i.style.paddingTop = "2px";
                e.appendChild(i);
                i = document.createElement("td");
                i.appendChild(document.createTextNode(c[1]));
                i.className = "google-ac-d";
                e.appendChild(i)
            }
        }
        if (P && b > 0) a = w.insertRow( - 1),
        a.onmousedown = Aa,
        b = document.createElement("td"),
        b.colSpan = 2,
        a.className = "google-ac-e",
        d = document.createElement("span"),
        a.appendChild(b),
        b.appendChild(d),
        d.appendChild(document.createTextNode(P)),
        d.onclick = function() {
            S();
            o = "";
            window.clearTimeout(q);
            q = f;
            B.value = "x"
        }
    }
    function Aa(a) {
        a && a.stopPropagation ? (a.stopPropagation(), $(), v.focus()) : K = !0;
        return ! 1
    }
    function Ba() {
        var a = f;
        try {
            a = new ActiveXObject("Msxml2.XMLHTTP")
        } catch(b) {
            try {
                a = new ActiveXObject("Microsoft.XMLHTTP")
            } catch(d) {
                a = f
            }
        } ! a && typeof XMLHttpRequest != "undefined" && (a = new XMLHttpRequest);
        return a
    }
    function za(a) {
        D && D.readyState != 0 && D.readyState != 4 && D.abort();
        if (D) D.onreadystatechange = Ca;
        if (D = Ba()) D.open("GET", E + "&q=" + a + "&cp=" + p, !0),
        D.onreadystatechange = function() {
            if (D.readyState == 4) switch (D.status) {
            case 403:
                G = 1E3;
                break;
            case 302:
            case 500:
            case 502:
            case 503:
                G++;
                break;
            case 200:
                xa(eval(D.responseText));
            default:
                G = 0
            }
        },
        D.send(f)
    }
    function Ca() {}
    function Da() {
        var a = v.value;
        a != k && X(0);
        k = a
    }
    function qa() {
        var a = v,
        b = 0,
        d = 0,
        c;
        try {
            c = typeof a.selectionStart == "number"
        } catch(e) {
            c = !1
        }
        if (c) b = a.selectionStart,
        d = a.selectionEnd;
        if (N && (a = a.createTextRange(), c = document.selection.createRange(), a.inRange(c))) a.setEndPoint("EndToStart", c),
        b = a.text.length,
        a.setEndPoint("EndToEnd", c),
        d = a.text.length;
        if (b && d && b == d) return b;
        return 0
    }
    g("install_sugg",
    function(a, b, d, c, e, i, A, m, ea, fa, ga, ra) {
        u = a;
        v = b;
        ba = c;
        P = e;
        ia = i;
        fa && (ca = fa);
        if (Ba() != f) {
            J = /^(zh-(CN|TW)|ja|ko)$/.test(A);
            E = ["/complete/search?hl=", A, ga ? "&gl=" + ga: "", d ? "&ds=" + d: "", ea ? "&pq=" + (encodeURIComponent || escape)(ea) : "", m ? "&expid=" + m: "", ra ? "&tok=" + (encodeURIComponent || escape)(ra) : "", "&client=products&hjson=t"].join("");
            u.onsubmit = ua;
            v.setAttribute("autocomplete", "off");
            h(v, "blur", na);
            h(v, "beforedeactivate", oa);
            v.addEventListener ? (da ? v.onkeydown = T: v.onkeypress = T, v.onkeyup = pa) : (h(v, N ? "keydown": "keypress", T), h(v, "keyup", pa));
            l = n = k = v.value;
            p = qa();
            w = document.createElement("table");
            w.id = "completeTable";
            w.cellSpacing = w.cellPadding = "0";
            x = w.style;
            w.className = "google-ac-m";
            S();
            document.body.appendChild(w);
            if (N) y = document.createElement("iframe"),
            z = y.style,
            y.id = "completeIFrame",
            z.zIndex = "1",
            z.position = "absolute",
            z.display = "block",
            z.borderWidth = 0,
            document.body.appendChild(y);
            Q();
            ka();
            h(window, "resize", Q);
            h(window, "pageshow", ja);
            J && window.setInterval(Da, 10);
            B = ma("aq", "f", !1);
            C = ma("oq", l, !0);
            Z()
        }
    });
    g("ac_hr", xa);
})()