<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }} - Programming Courses</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <!-- Additional styles for specific pages -->
    {{!get('styles', '')}}
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
    <style>
        body {
            background-image: url('/static/images/background.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            color: white;
        }
    </style>
</head>

<body>
    <div class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
        <li><a href="/">Home</a></li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: #ffcc00; font-weight: bold;">
                <i class="glyphicon glyphicon-user"></i> Yumashkin <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" style="background-color: #2c3e50; border: 1px solid #34495e;">
                <li><a href="/reviews" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-comment"></i> Reviews
                </a></li>
                <li><a href="/articles" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-book"></i> Useful Articles
                </a></li>
                <li><a href="/orders" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-shopping-cart"></i> Orders
                </a></li>
                <li><a href="/news" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-bullhorn"></i> Latest News
                </a></li>
                <li><a href="/partners" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-handshake"></i> Partner Companies
                </a></li>
                <li><a href="/users" style="color: #ecf0f1; padding: 10px 20px;">
                    <i class="glyphicon glyphicon-stats"></i> Active Users
                </a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: #00ccff; font-weight: bold;">
                <i class="glyphicon glyphicon-user"></i> Tovstogan <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" style="background-color: #2c3e50; border: 1px solid #34495e;">
                <li><a href="/reviews2" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-comment"></i> Reviews
                </a></li>
                <li><a href="/articles2" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-book"></i> Useful Articles
                </a></li>
                <li><a href="/orders2" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-shopping-cart"></i> Orders
                </a></li>
                <li><a href="/news2" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-bullhorn"></i> Latest News
                </a></li>
                <li><a href="/partners2" style="color: #ecf0f1; padding: 10px 20px; border-bottom: 1px solid #34495e;">
                    <i class="glyphicon glyphicon-handshake"></i> Partner Companies
                </a></li>
                <li><a href="/users2" style="color: #ecf0f1; padding: 10px 20px;">
                    <i class="glyphicon glyphicon-stats"></i> Active Users
                </a></li>
            </ul>
        </li>
    </ul>
</div>

    <div class="container body-content">
        {{!base}}
        <hr />
        <footer>
            <p>&copy; {{ year }} - Programming Courses</p>
        </footer>
    </div>

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>
</body>
</html>