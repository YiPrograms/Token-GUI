import os
import sys

from PyQt5.QtCore import QUrl, QObject, QTranslator, QLocale
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
import resources
from tokensmodel import TokensModel

os.environ['QT_QUICK_CONTROLS_STYLE'] = "Material"
app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
translator = QTranslator()
translation_found = translator.load('translations/' + QLocale.system().name())
app.installTranslator(translator)

if translation_found:
    print("Loaded translation:", QLocale.system().name())
else:
    print("Translation not found:", QLocale.system().name())

n_tokens = 10
tokens = TokensModel()
for i in range(n_tokens):
    tokens.addToken("Token", i)

context = engine.rootContext()
context.setContextProperty('tokens', tokens)





engine.load(QUrl('qml/token-gui.qml'))
if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec_())
