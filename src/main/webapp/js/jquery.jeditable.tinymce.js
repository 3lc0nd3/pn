/*
 * Wysiwyg input for Jeditable
 *
 * Copyright (c) 2008 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 * 
 * Depends on jWYSIWYG plugin by Juan M Martinez:
 *   http://projects.bundleweb.com.ar/jWYSIWYG/
 *
 * Project home:
 *   http://www.appelsiini.net/projects/jeditable
 *
 * Revision: $Id$
 *
 */

$.editable.addInputType('mce', {
    element:function (settings, original) {
        var textarea = $('<textarea id="' + $(original).attr("id") + '_mce"/>');
        if (settings.rows) {
            textarea.attr('rows', settings.rows);
        } else {
            textarea.height(settings.height);
        }
        if (settings.cols) {
            textarea.attr('cols', settings.cols);
        } else {
            console.log("Text area width: " + settings.width);
            textarea.width(settings.width);
        }
        $(this).append(textarea);
        return(textarea);
    },
    plugin:function (settings, original) {
        tinyMCE.execCommand("mceAddControl", true, $(original).attr("id") + '_mce');
    },
    submit:function (settings, original) {
        tinyMCE.triggerSave();
        tinyMCE.execCommand("mceRemoveControl", true, $(original).attr("id") + '_mce');
    },
    reset:function (settings, original) {
        tinyMCE.execCommand("mceRemoveControl", true, $(original).attr("id") + '_mce');
        original.reset(this);
    }
});