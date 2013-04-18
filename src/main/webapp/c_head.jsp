<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
    <%  String str2=""+request.getAttribute("servicio");
//                System.out.println("str2 = " + str2);

%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta charset="utf-8">
    <title>
        <%=pnManager.getTexto(1).getTexto1()%>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">


    <!-- Stylesheets -->
    <link href="style/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="style/font-awesome.css">
    <link href="style/prettyPhoto.css" rel="stylesheet">
    <link rel="stylesheet" href="style/slider.css">
    <link href="style/style.css" rel="stylesheet">

    <%-- Data Table--%>
    <link href="js/datatable/css/demo_page.css" rel="stylesheet">
    <link href="js/datatable/css/demo_table.css" rel="stylesheet">
    <link href="js/datatable/css/shCore.css" rel="stylesheet">

    <!-- Colors - Orange, Purple, Green and Blue -->
    <%--<link href="style/orange.css" rel="stylesheet">--%>
    <%--<link href="style/purple.css" rel="stylesheet">--%>
    <%--<link href="style/green.css" rel="stylesheet">--%>
    <link href="style/blue.css" rel="stylesheet">

    <link href="style/bootstrap-responsive.css" rel="stylesheet">
    <link href="js/datePicker/datepicker.css" rel="stylesheet">

    <!-- HTML5 Support for IE -->
    <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

    <!-- Favicon -->
    <link rel="shortcut icon" href="img/favicon/favicon.png">
    <link href="style/purchase.css" rel="stylesheet">

    <style type="text/css">
        select, option{
            background-color: #ffffff;
            color: #0000d5;
        }
    </style>

</head>

<body>