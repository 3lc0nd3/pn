if (!window.Dialog)
	var Dialog = new Object();

Dialog.Methods = {
    _init: function() {
      this.overlay = new Element('div', { id: "MB_overlay" ,opacity: "0.6"  }) ;
        Object.extend(this.overlay.style, {
        	position: 'absolute',
        	top: 0,
        	left: 0,
        	zIndex: 90,
        	width: '100%',
        	backgroundColor: '#ECECFF',
        	display: 'none'
        });
      this.dialog_box = new Element('div', { id: "MB_Box" ,className: "loading" }).update("Loading...");
	  document.body.insertBefore(this.overlay, document.body.childNodes[0]);
	  document.body.insertBefore(this.dialog_box, document.body.childNodes[0]);
      this.dialog_box.show = this.show.bind(this);
      this.dialog_box.persistent_show = this.persistent_show.bind(this);
      this.dialog_box.hide = this.hide.bind(this);

      this.parent_element = this.dialog_box.parentNode;
      this.dialog_box.style.position = "absolute";
      var e_dims = Element.getDimensions(this.dialog_box);
      var b_dims = Element.getDimensions(this.overlay);

      this.dialog_box.style.zIndex = this.overlay.style.zIndex + 1;
    },
    moveDialogBox: function(where) {
      Element.remove(this.dialog_box);
      if(where == 'back')
        this.dialog_box = this.parent_element.appendChild(this.dialog_box);
      else
        this.dialog_box = this.overlay.parentNode.insertBefore(this.dialog_box, this.overlay);
    },

    show: function() {
		this._init();
document.documentElement.style.overflowX = 'hidden';	 // horizontal scrollbar will be hidden
		document.documentElement.style.overflowY = 'hidden';
		this.overlay.style.display = "block";
		this.overlay.style.height = this.bodyHeight()+'px';
		this.moveDialogBox('out');
		//this.overlay.onclick = this.hide.bind(this);
		this._toggleSelects();

		//new Effect.Appear(this.overlay, {duration: 0.1, from: 0.0, to: 0.3});
		this.dialog_box.style.display = 'block';
		this.dialog_box.style.left = '0px';

		var e_dims = Element.getDimensions(this.dialog_box);
		var w_dim = this._viewport();
		this.dialog_box.style.left = ((w_dim.width/2) - (e_dims.width)/2) + 'px';
		this.dialog_box.style.top = this.getScrollTop() + ((w_dim.height - (e_dims.width/2))/2) + 'px';

    },

    getScrollTop: function() {
    	return (window.pageYOffset)?window.pageYOffset:(document.documentElement && document.documentElement.scrollTop)?document.documentElement.scrollTop:document.body.scrollTop;
    },

    persistent_show: function() {
      this.overlay.style.height = this.bodyHeight()+'px';
      this.moveDialogBox('out');

      this._toggleSelects();
      //new Effect.Appear(this.overlay, {duration: 0.1, from: 0.0, to: 0.3});

      this.dialog_box.style.display = '';
    	this.dialog_box.style.left = '0px';
      var e_dims = Element.getDimensions(this.dialog_box);
    	this.dialog_box.style.left = ((this.winWidth()/2) - (e_dims.width)/2) + 'px';

    },

    hide: function() {
      this._toggleSelects();
      //new Effect.Fade(this.overlay, {duration: 0.1});
	  this.overlay.style.display = 'none';
      this.dialog_box.style.display = 'none';
      this.moveDialogBox('back');
      $A(this.dialog_box.getElementsByTagName('input')).each(function(e){if(e.type!='submit')e.value=''});
    },

    // For IE browsers -- hiding all SELECT elements
	_toggleSelects: function() {
		if (navigator.appVersion.match(/\bMSIE\b/))
			$$("select").each( function(select) {
				select.style.visibility = (select.style.visibility == "") ? "hidden" : "";
			});
	},

	bodyWidth: function() {
		return document.body.offsetWidth || window.innerWidth || document.documentElement.clientWidth || 0;
		},
	bodyHeight: function() {
			return document.body.offsetHeight || window.innerHeight || document.documentElement.clientHeight || 0;
		},

   _viewport: function() {
		 var width;var height;
		 /* the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
		 *IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
		 */
		 if (typeof window.innerWidth != 'undefined'){
				width = window.innerWidth ;
				height = window.innerHeight ;
		 }else if (typeof document.documentElement != 'undefined'
			 && typeof document.documentElement.clientWidth != 'undefined'
			 && document.documentElement.clientWidth != 0){
				width = document.documentElement.clientWidth;
				height = document.documentElement.clientHeight;
		 }else{// older versions of IE
				width = document.getElementsByTagName('body')[0].clientWidth;
				height = document.getElementsByTagName('body')[0].clientHeight;
		 }
		 return {'width':width,'height':height};
     }
  };

  Object.extend(Dialog, Dialog.Methods);
