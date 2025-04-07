"""
This script runs the application using a development server.
"""

import bottle
import os
import sys
from datetime import datetime

if '--debug' in sys.argv[1:] or 'SERVER_DEBUG' in os.environ:
    bottle.debug(True)

def wsgi_app():
    return bottle.default_app()

if __name__ == '__main__':
    # Configure paths
    PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
    STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
    VIEWS_ROOT = os.path.join(PROJECT_ROOT, 'views').replace('\\', '/')
    
    # Ensure views directory exists
    if not os.path.exists(VIEWS_ROOT):
        os.makedirs(VIEWS_ROOT)
    
    bottle.TEMPLATE_PATH.insert(0, VIEWS_ROOT)

    # Server configuration
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555

    # Routes
    @bottle.route('/')
    def index():
        return bottle.template('index', year=datetime.now().year)

    @bottle.route('/python')
    def python_course():
        return bottle.template('python_course', year=datetime.now().year)
    
    @bottle.route('/cpp')
    def cpp_course():
        return bottle.template('cpp_course', year=datetime.now().year)

    @bottle.route('/static/<filepath:path>')
    def server_static(filepath):
        return bottle.static_file(filepath, root=STATIC_ROOT)

    # Start server
    try:
        bottle.run(host=HOST, port=PORT)
    except Exception as e:
        print(f"Server error: {str(e)}")