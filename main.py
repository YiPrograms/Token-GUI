import os
import sys

from PyQt5.QtCore import QUrl, QObject
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from resources import resources  # load resources built by pyrcc5

from tokensmodel import TokensModel


os.environ['QT_QUICK_CONTROLS_STYLE'] = "Material"
app = QApplication(sys.argv)
engine = QQmlApplicationEngine()



n_tokens = 10
tokens = TokensModel()
for i in range(n_tokens):
    tokens.addToken("Token", i)

context = engine.rootContext()
context.setContextProperty('tokens', tokens)





engine.load(QUrl('qrc:/resources/qml/token-gui.qml'))
if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec_())
