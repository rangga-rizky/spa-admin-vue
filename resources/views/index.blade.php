<!DOCTYPE html>
<html>
<head>
	<meta name="csrf-token" content="{{ csrf_token() }}">
	<!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>POS Apps</title>

	 <!-- Font Awesome -->
    <link rel="stylesheet" href="{{url('admin-lte/plugins/font-awesome/css/font-awesome.min.css')}}">
    <link rel="stylesheet" type="text/css" href="{{url('admin-lte/plugins/datatables/dataTables.bootstrap4.min.css')}}">
	<link rel="stylesheet" type="text/css" href="{{url('admin-lte/css/adminlte.min.css')}}">
	<link rel="stylesheet" type="text/css" href="{{url('css/signin.css')}}">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<!-- Google Font: Source Sans Pro -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition sidebar-mini">
	<div id="app" style="width:100%">
		<layout></layout>
	</div>
</body>
<script src="{{  URL::asset('js/app.js') }}"></script>
<!-- jQuery -->
<script src="{{  URL::asset('admin-lte/plugins/jquery/jquery.min.js') }}" ></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Sparkline -->
<script src="{{  URL::asset('admin-lte/plugins/sparkline/jquery.sparkline.min.js') }}"></script>
<!-- Slimscroll -->
<script src="{{  URL::asset('admin-lte/plugins/slimScroll/jquery.slimscroll.min.js') }}"></script>
<!-- FastClick -->
<script src="{{  URL::asset('admin-lte/plugins/fastclick/fastclick.js') }}"></script>
<!-- AdminLTE App -->
<script src="{{  URL::asset('admin-lte/js/adminlte.js') }}"></script>
</html>