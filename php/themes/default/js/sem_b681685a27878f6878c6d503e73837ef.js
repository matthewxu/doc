(function() {
  try {
    var h = true,
    i = null,
    l = false,
    n;
    window.gbar.tev && window.gbar.tev(3, "m");
    var o = this,
    p = function(a) {
      a = a.split(".");
      for (var b = o,
      c; c = a.shift();) if (b[c] != i) b = b[c];
      else return i;
      return b
    },
    da = function(a) {
      var b = typeof a;
      if (b == "object") if (a) {
        if (a instanceof Array) return "array";
        else if (a instanceof Object) return b;
        var c = Object.prototype.toString.call(a);
        if (c == "[object Window]") return "object";
        if (c == "[object Array]" || typeof a.length == "number" && typeof a.splice != "undefined" && typeof a.propertyIsEnumerable != "undefined" && !a.propertyIsEnumerable("splice")) return "array";
        if (c == "[object Function]" || typeof a.call != "undefined" && typeof a.propertyIsEnumerable != "undefined" && !a.propertyIsEnumerable("call")) return "function"
      } else return "null";
      else if (b == "function" && typeof a.call == "undefined") return "object";
      return b
    },
    ea = function(a) {
      return a.call.apply(a.bind, arguments)
    },
    fa = function(a, b) {
      var c = b || o;
      if (arguments.length > 2) {
        var d = Array.prototype.slice.call(arguments, 2);
        return function() {
          var e = Array.prototype.slice.call(arguments);
          Array.prototype.unshift.apply(e, d);
          return a.apply(c, e)
        }
      } else return function() {
        return a.apply(c, arguments)
      }
    },
    r = function() {
      r = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? ea: fa;
      return r.apply(i, arguments)
    },
    u = function(a, b) {
      var c = a.split("."),
      d = o; ! (c[0] in d) && d.execScript && d.execScript("var " + c[0]);
      for (var e; c.length && (e = c.shift());) if (!c.length && b !== undefined) d[e] = b;
      else d = d[e] ? d[e] : d[e] = {}
    };
    var ga = function() {}; (function(a) {
      a.P = function() {
        return a.Q || (a.Q = new a)
      }
    })(ga);
    var v = i;
    var w = {
      aa: 1,
      ca: 2,
      la: 3,
      Y: 4,
      I: 5,
      G: 6,
      ba: 7,
      H: 8,
      pa: 9,
      ka: 10,
      da: 11,
      ja: 12,
      ia: 13,
      ea: 14,
      ha: 15,
      ga: 16,
      na: 17,
      $: 18,
      fa: 19,
      oa: 20,
      ma: 21,
      Z: 22
    };
    var A = window.gbar;
    var B = {
      z: 1,
      X: 2,
      W: 3,
      C: 4,
      B: 5,
      F: 6,
      D: 7,
      A: 8
    };
    var C = [],
    D = i,
    E = function(a, b) {
      var c = i;
      if (b) c = {
        m: b
      };
      A.tev && A.tev(a, "m", c)
    };
    var H, ma = function() {
      H = /MSIE (\d+)\.(\d+);/.exec(navigator.userAgent);
      ha();
      u("gbar.close", ia);
      u("gbar.cls", ja);
      u("gbar.tg", ka);
      A.adh("gbd4",
      function() {
        la(w.I, !I)
      });
      A.adh("gbd5",
      function() {
        la(w.G, !I)
      })
    },
    J = "",
    I = undefined,
    K = undefined,
    L = undefined,
    M = undefined,
    na = l,
    oa = ["gbzt", "gbgt", "gbg0l", "gbmt", "gbml1"],
    N = function(a, b, c, d) {
      var e = "on" + b;
      if (a.addEventListener) a.addEventListener(b, c, !!d);
      else if (a.attachEvent) a.attachEvent(e, c);
      else {
        var f = a[e];
        a[e] = function() {
          var g = f.apply(this, arguments),
          j = c.apply(this, arguments);
          return g == undefined ? j: j == undefined ? g: j && g
        }
      }
    },
    Q = function(a) {
      return document.getElementById(a)
    },
    R = function(a) {
      var b = {};
      if (a.style.display != "none") {
        b.width = a.offsetWidth;
        b.height = a.offsetHeight;
        return b
      }
      var c = a.style,
      d = c.display,
      e = c.visibility,
      f = c.position;
      c.visibility = "hidden";
      c.position = "absolute";
      c.display = "inline";
      var g;
      g = a.offsetWidth;
      a = a.offsetHeight;
      c.display = d;
      c.position = f;
      c.visibility = e;
      b.width = g;
      b.height = a;
      return b
    },
    pa = function(a) {
      if (L === undefined) {
        var b = document.body.style;
        L = !(b.WebkitBoxShadow !== undefined || b.MozBoxShadow !== undefined || b.boxShadow !== undefined || b.BoxShadow !== undefined)
      }
      if (L) {
        b = a.id + "-gbxms";
        var c = Q(b);
        if (!c) {
          c = document.createElement("span");
          c.id = b;
          c.className = "gbxms";
          a.appendChild(c)
        }
        if (M === undefined) M = c.offsetHeight < a.offsetHeight / 2;
        if (M) {
          c.style.height = a.offsetHeight - 5 + "px";
          c.style.width = a.offsetWidth - 3 + "px"
        }
      }
    },
    qa = function(a, b) {
      if (a) {
        var c = a.style,
        d = b || Q(J);
        if (d) {
          a.parentNode && a.parentNode.appendChild(d);
          d = d.style;
          d.width = a.offsetWidth + "px";
          d.height = a.offsetHeight + "px";
          d.top = "32px";
          d.left = c.left;
          d.right = c.right
        }
      }
    },
    T = function() {
      try {
        if (I) {
          var a = Q(J);
          if (a) a.style.visibility = "hidden";
          var b = Q(I);
          if (b) {
            b.style.visibility = "hidden";
            var c = b.getAttribute("aria-owner"),
            d = c ? Q(c) : i;
            if (d) {
              S(d.parentNode, "gbto");
              d.blur()
            }
          }
          if (K) {
            K();
            K = undefined
          }
          var e = A.ch[I];
          if (e) {
            a = 0;
            for (var f; f = e[a]; a++) try {
              f()
            } catch(g) {
              A.logger.ml(g)
            }
          }
          I = undefined
        }
      } catch(j) {
        A.logger.ml(j)
      }
    },
    la = function(a, b) {
      var c = {
        s: b ? "o": "c"
      };
      a != -1 && A.logger.il(a, c)
    },
    V = function(a, b) {
      var c = a.className;
      U(a, b) || (a.className += (c != "" ? " ": "") + b)
    },
    S = function(a, b) {
      var c = a.className,
      d = RegExp("\\s?\\b" + b + "\\b");
      if (c && c.match(d)) a.className = c.replace(d, "")
    },
    U = function(a, b) {
      var c = a.className;
      return !! (c && c.match(RegExp("\\b" + b + "\\b")))
    },
    ka = function(a, b, c) {
      try {
        a = a || window.event;
        c = c || l;
        if (!J) {
          var d = document.createElement(Array.every || window.createPopup ? "iframe": "div");
          d.frameBorder = "0";
          J = d.id = "gbs";
          d.src = "javascript:''";
          Q("gbw").appendChild(d)
        }
        if (!na) {
          N(document, "click", ia);
          N(document, "keyup", ra);
          na = h
        }
        if (!c) {
          a.preventDefault && a.preventDefault();
          a.returnValue = l;
          a.cancelBubble = h
        }
        if (!b) {
          b = a.target || a.srcElement;
          for (var e = b.parentNode.id; ! U(b.parentNode, "gbt");) {
            if (e == "gb") return;
            b = b.parentNode;
            e = b.parentNode.id
          }
        }
        var f = b.getAttribute("aria-owns");
        if (f.length) {
          b.focus();
          if (I == f) ja(f);
          else {
            var g = b.offsetWidth;
            a = 0;
            do a += b.offsetLeft || 0;
            while (b = b.offsetParent);
            var j, m = document.body,
            q, t = document.defaultView;
            if (t && t.getComputedStyle) {
              var F = t.getComputedStyle(m, "");
              if (F) q = F.direction
            } else q = m.currentStyle ? m.currentStyle.direction: m.style.direction;
            b = (j = q == "rtl") ? l: h;
            j = j ? l: h;
            if (f == "gbd") j = !j;
            I && T();
            var k = A.bh[f];
            if (k) for (var x = 0,
            y; y = k[x]; x++) try {
              y()
            } catch(aa) {
              A.logger.ml(aa)
            }
            k = a;
            var s = Q(f);
            if (s) {
              var z = s.style,
              O = s.offsetWidth;
              if (O < g) {
                z.width = g + "px";
                O = g;
                var ta = s.offsetWidth;
                if (ta != g) z.width = g - (ta - g) + "px"
              }
              var P, G, ba = document.documentElement && document.documentElement.clientWidth ? document.documentElement.clientWidth: document.body.clientWidth;
              if (j) {
                P = b ? Math.max(ba - k - O, 5) : ba - k - g;
                G = -(ba - k - g - P);
                if (H && H.length > 1) {
                  var ua = new Number(H[1]);
                  if (ua == 6 || ua == 7 && document.compatMode == "BackCompat") G -= 2
                }
              } else {
                P = b ? k: Math.max(k + g - O, 5);
                G = P - k
              }
              var va = Q("gbw"),
              wa = Q("gb");
              if (va && wa) {
                var xa = va.offsetLeft;
                if (xa != wa.offsetLeft) G -= xa
              }
              pa(s);
              z.top = "32px";
              z.right = j ? G + "px": "auto";
              z.left = j ? "auto": G + "px";
              z.visibility = "visible";
              var ya = s.getAttribute("aria-owner"),
              za = ya ? Q(ya) : i;
              za && V(za.parentNode, "gbto");
              var ca = Q(J);
              if (ca) {
                qa(s, ca);
                ca.style.visibility = "visible"
              }
              I = f
            }
            var Aa = A.dh[f];
            if (Aa) for (x = 0; y = Aa[x]; x++) try {
              y()
            } catch(Wa) {
              A.logger.ml(Wa)
            }
          }
        }
      } catch(Xa) {
        A.logger.ml(Xa)
      }
    },
    ra = function(a) {
      if (I) try {
        a = a || window.event;
        var b = a.target || a.srcElement;
        if (a.keyCode && b) if (a.keyCode && a.keyCode == 27) T();
        else if (b.tagName.toLowerCase() == "a" && b.className.indexOf("gbgt") != -1 && (a.keyCode == 13 || a.keyCode == 3)) {
          var c = document.getElementById(I);
          if (c) {
            var d = c.getElementsByTagName("a");
            d && d.length && d[0].focus && d[0].focus()
          }
        }
      } catch(e) {
        A.logger.ml(e)
      }
    },
    ha = function() {
      var a = Q("gb");
      if (a) {
        S(a, "gbpdjs");
        a = a.getElementsByTagName("a");
        for (var b = 0,
        c; c = a[b]; b++) {
          for (var d = l,
          e = 0,
          f; f = oa[e]; e++) if (U(c, f)) {
            d = h;
            break
          }
          d && sa(c, f)
        }
      }
    },
    sa = function(a, b) {
      var c = function(d, e) {
        return function(f) {
          var g;
          try {
            g = f || window.event;
            var j = g.relatedTarget,
            m;
            if (! (m = d === j)) {
              f = j;
              if (d === f) m = l;
              else {
                for (; f && f !== d;) f = f.parentNode;
                m = f === d
              }
            }
            if (!m) {
              m = e + "-hvr";
              if (g.type == "mouseover") {
                V(d, m);
                var q = document.activeElement;
                if (q) {
                  var t = U(q, "gbgt") || U(q, "gbzt"),
                  F = U(d, "gbgt") || U(d, "gbzt");
                  t && F && q.blur()
                }
              } else g.type == "mouseout" && S(d, m)
            }
          } catch(k) {
            A.logger.ml(k)
          }
        }
      } (a, b);
      N(a, "mouseover", c);
      N(a, "mouseout", c)
    },
    Ba = function(a) {
      for (; a && a.hasChildNodes();) a.removeChild(a.firstChild)
    },
    ia = function() {
      T()
    },
    ja = function(a) {
      a == I && T()
    },
    W = function(a, b) {
      var c = document.createElement(a);
      c.className = b;
      return c
    },
    Ca = function(a) {
      if (a && a.style.visibility == "visible") {
        pa(a);
        qa(a)
      }
    };
    C.push(["base", {
      init: function(a) {
        ma(a)
      }
    }]);
    var X = function(a) {
      u("gbar.pcm", r(this.K, this));
      u("gbar.paa", r(this.J, this));
      u("gbar.prm", r(this.U, this));
      u("gbar.pge", r(this.k, this));
      u("gbar.ppe", r(this.u, this));
      this.r = this.h = this.v = this.b = this.f = l;
      this.M = a.mg || "%1$s";
      this.L = a.md || "%1$s";
      this.j = a.g;
      this.N = a.d;
      this.a = a.e;
      this.n = a.p;
      this.O = a.m;
      var b = Q("gbmpn");
      if (b && b.firstChild && b.firstChild.nodeValue == this.a) {
        b = this.a.indexOf("@");
        b >= 0 && Da(this, this.a.substring(0, b))
      } (b = Q("gbi4i")) && b.loadError && this.k(); (b = Q("gbmpi")) && b.loadError && this.u();
      if (!this.f) {
        b = Q("gbd4");
        var c = Q("gbmp2"),
        d = Q("gbmpsb");
        b && N(b, "click", r(this.R, this), h);
        if (c && d) {
          N(c, "click", r(this.w, this));
          N(d, "click", r(this.w, this))
        }
        this.f = h
      }
      if (this.j) {
        b = Q("gbpm");
        c = Q("gbpms");
        if (b && c) {
          var e = c.innerHTML.split("%1$s");
          if (e.length == 2) {
            d = document.createTextNode(e[0]);
            e = document.createTextNode(e[1]);
            var f = W("span", "gbpms2"),
            g = document.createTextNode(this.O);
            Ba(c);
            f.appendChild(g);
            c.appendChild(d);
            c.appendChild(f);
            c.appendChild(e);
            b.style.display = ""
          }
        }
      }
      if (a.xp)(b = Q("gbg4")) && N(b, "mouseover", r(this.V, this));
      if (a.xa) {
        if (p("__PVT")) this.h = h;
        if (this.j && !this.N) if (this.h && !this.r) {
          this.r = h;
          p("googleapis") ? this.o() : A.qGC(r(this.o, this))
        }
      }
    };
    n = X.prototype;
    n.R = function(a) {
      try {
        if (I) for (var b = a.target || a.srcElement; b.tagName.toLowerCase() != "a";) {
          if (b.id == "gbd4") {
            a.cancelBubble = h;
            return b
          }
          b = b.parentNode
        }
      } catch(c) {
        A.logger.ml(c)
      }
      return i
    };
    n.w = function(a) {
      try {
        a = a || window.event;
        a.cancelBubble = h;
        a.stopPropagation && a.stopPropagation();
        a.preventDefault && a.preventDefault();
        var b = Q("gbmps");
        if (b) {
          var c = b.style.display == "none";
          try {
            var d = Q("gbd4"),
            e = Q("gbmps"),
            f = Q("gbmpdv");
            if (d && e && f) {
              f.style.display = c ? "none": "";
              e.style.display = c ? "": "none";
              Ca(d)
            }
          } catch(g) {
            A.logger.ml(g)
          }
        }
      } catch(j) {
        A.logger.ml(j)
      }
      return l
    };
    n.K = function() {
      try {
        var a = Q("gbmpas");
        a && Ba(a);
        this.b = l
      } catch(b) {
        A.logger.ml(b)
      }
    };
    n.U = function() {
      var a = Q("gbmpdv"),
      b = Q("gbmps");
      if (a && b) {
        a.style.display = "";
        b.style.display = "none";
        if (!this.b) {
          var c = Q("gbmpal"),
          d = Q("gbpm");
          if (c) {
            a.style.width = "";
            b.style.width = "";
            c.style.width = "";
            if (d) d.style.width = "1px";
            var e = R(a).width,
            f = R(b).width;
            e = e > f ? e: f;
            if (f = Q("gbg4")) {
              f = R(f).width;
              if (f > e) e = f
            }
            if (H && H.length > 1) {
              f = new Number(H[1]);
              if (f == 6 || f == 7 && document.compatMode == "BackCompat") e += 2
            }
            e += "px";
            a.style.width = e;
            b.style.width = e;
            c.style.width = e;
            if (d) d.style.width = e;
            this.b = h
          }
        }
      }
    };
    n.J = function(a, b, c, d, e, f, g, j) {
      try {
        var m = Q("gbmpas");
        if (m) {
          var q = "gbmtc";
          if (a) q += " gbmpmta";
          var t = W("div", q),
          F = W("div", "gbmpph");
          t.appendChild(F);
          var k = W(f ? "a": "span", "gbmpl");
          V(k, "gbmt");
          if (f) {
            if (j) for (var x in j) k.setAttribute(x, j[x]);
            k.href = g;
            sa(k, "gbmt")
          }
          t.appendChild(k);
          var y = W("span", "gbmpmn");
          k.appendChild(y);
          y.appendChild(document.createTextNode(d || e));
          if (a) {
            var aa = W("span", "gbmpmtc");
            y.appendChild(aa)
          }
          var s = W("span", "gbmpme");
          k.appendChild(s);
          a = e;
          if (b) a = this.L.replace("%1$s", e);
          else if (c) a = this.M.replace("%1$s", e);
          s.appendChild(document.createTextNode(a));
          m.appendChild(t)
        }
      } catch(z) {
        A.logger.ml(z)
      }
    };
    n.o = function() {
      window.googleapis.people.get({
        id: "@me"
      }).execute(r(this.S, this))
    };
    n.S = function(a) {
      try {
        if (a && !a.error) {
          var b = a.displayName;
          b && Da(this, b)
        }
      } catch(c) {
        A.logger.ml(c)
      }
    };
    var Da = function(a, b) {
      var c = Q("gbd4"),
      d = Q("gbmpn");
      if (c && d) {
        Ba(d);
        d.appendChild(document.createTextNode(b));
        Ca(c)
      }
    };
    X.prototype.k = function() {
      try {
        Ea(this, "gbi4i", "gbi4id")
      } catch(a) {
        A.logger.ml(a)
      }
    };
    X.prototype.u = function() {
      try {
        Ea(this, "gbmpi", "gbmpid")
      } catch(a) {
        A.logger.ml(a)
      }
    };
    var Ea = function(a, b, c) {
      if (a = Q(b)) a.style.display = "none";
      if (c = Q(c)) c.style.display = ""
    };
    X.prototype.V = function() {
      if (!this.v) {
        this.v = h;
        var a = Q("gbmpi");
        if (a && this.n) a.src = this.n
      }
    };
    C.push(["prf", {
      init: function(a) {
        new X(a)
      }
    }]);
    C.push(["il", {
      init: function() {
        ga.P();
        var a = w.H,
        b;
        v || (v = p("gbar.logger") || {});
        b = v;
        da(b.il) == "function" && b.il(a, void 0)
      }
    }]);
    function Fa(a, b) {
      if (window.gbar.logger._itl(b)) return b;
      var c = a.stack;
      if (c) {
        c = c.replace(/\s*$/, "").split("\n");
        for (var d = [], e = 0; e < c.length; e++) d.push(Ga(c[e]));
        c = d
      } else c = Ha();
      d = c;
      e = 0;
      for (var f = d.length - 1,
      g = 0; g <= f; g++) if (d[g] && d[g].name.indexOf("_mlToken") >= 0) {
        e = g + 1;
        break
      }
      e == 0 && f--;
      c = [];
      for (g = e; g <= f; g++) d[g] && !(d[g].name.indexOf("_onErrorToken") >= 0) && c.push("> " + Ia(d[g]));
      d = [b, "&jsst=", c.join("")];
      e = d.join("");
      if (!window.gbar.logger._itl(e)) return e;
      if (c.length > 2) {
        d[2] = c[0] + "..." + c[c.length - 1];
        e = d.join("");
        if (!window.gbar.logger._itl(e)) return e
      }
      return b
    }
    C.push(["er", {
      init: function() {
        window.gbar.logger._aem = Fa
      }
    }]);
    function Ga(a) {
      var b = a.match(Ja);
      if (b) return new Ka(b[1] || "", b[2] || "", b[3] || "", "", b[4] || b[5] || "");
      if (b = a.match(La)) return new Ka("", b[1] || "", "", b[2] || "", b[3] || "");
      return i
    }
    var Ja = RegExp("^    at(?: (?:(.*?)\\.)?((?:new )?(?:[a-zA-Z_$][\\w$]*|<anonymous>))(?: \\[as ([a-zA-Z_$][\\w$]*)\\])?)? (?:\\(unknown source\\)|\\(native\\)|\\((?:eval at )?((?:http|https|file)://[^\\s)]+|javascript:.*)\\)|((?:http|https|file)://[^\\s)]+|javascript:.*))$"),
    La = /^([a-zA-Z_$][\w$]*)?(\(.*\))?@(?::0|((?:http|https|file):\/\/[^\s)]+|javascript:.*))$/;
    function Ha() {
      for (var a = [], b = arguments.callee.caller, c = 0; b && c < 20;) {
        var d;
        d = (d = Function.prototype.toString.call(b).match(Ma)) ? d[1] : "";
        var e = b,
        f = ["("];
        if (e.arguments) for (var g = 0; g < e.arguments.length; g++) {
          var j = e.arguments[g];
          g > 0 && f.push(", ");
          typeof j == "string" ? f.push('"', j, '"') : f.push(String(j))
        } else f.push("unknown");
        f.push(")");
        a.push(new Ka("", d, "", f.join(""), ""));
        try {
          if (b == b.caller) break;
          b = b.caller
        } catch(m) {
          break
        }
        c++
      }
      return a
    }
    var Ma = /^function ([a-zA-Z_$][\w$]*)/,
    Ka = function(a, b, c, d, e) {
      this.i = a;
      this.name = b;
      this.c = c;
      this.T = d;
      this.t = e
    },
    Ia = function(a) {
      var b = [a.i ? a.i + ".": "", a.name ? a.name: "anonymous", a.T, a.c ? " [as " + a.c + "]": ""];
      if (a.t) {
        b.push(" at ");
        b.push(a.t)
      }
      a = b.join("");
      for (b = window.location.href.replace(/#.*/, ""); a.indexOf(b) >= 0;) a = a.replace(b, "[page]");
      return a = a.replace(/http.*?extern_js.*?\.js/g, "[xjs]")
    };
    E(B.A);
    E(B.C);
    var Na, Y;
    for (Na = 0; Y = A.bnc[Na]; ++Na) if (Y[0] == "m") break;
    if (Y && !Y[1].l) {
      for (var Oa = A.mdc,
      Pa = A.mdi || {},
      Qa = 0,
      Ra; Ra = C[Qa]; ++Qa) {
        var Z = Ra[0],
        Sa = Oa[Z],
        Ta = Pa[Z],
        Ua;
        if (Ua = Sa) {
          var Va;
          if (Va = !Ta) {
            var Ya;
            a: {
              var Za = Z,
              $a = A.mdd;
              if ($a) try {
                if (!D) {
                  D = {};
                  for (var ab = $a.split(/;/), bb = 0; bb < ab.length; ++bb) D[ab[bb]] = h
                }
                Ya = D[Za];
                break a
              } catch(cb) {
                A.logger && A.logger.ml(cb)
              }
              Ya = l
            }
            Va = !Ya
          }
          Ua = Va
        }
        if (Ua) {
          E(B.F, Z);
          try {
            Ra[1].init(Sa);
            Pa[Z] = h
          } catch(db) {
            A.logger && A.logger.ml(db)
          }
          E(B.D, Z)
        }
      }
      var eb = A.qd.m;
      if (eb) {
        A.qd.m = [];
        for (var fb = 0,
        gb; gb = eb[fb]; ++fb) try {
          gb()
        } catch(hb) {
          A.logger && A.logger.ml(hb)
        }
      }
      Y[1].l = h;
      E(B.B);
      var ib;
      a: {
        for (var jb = 0,
        $; $ = A.bnc[jb]; ++jb) if (($[1].auto || $[0] == "m") && !$[1].l) {
          ib = l;
          break a
        }
        ib = h
      }
      ib && E(B.z)
    };
  } catch(e) {
    window.gbar && gbar.logger && gbar.logger.ml(e, {
      "_sn": "m.init"
    });
  }
})();