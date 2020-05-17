
from PyQt5.QtCore import Qt, pyqtSlot, QAbstractListModel, QModelIndex, QVariant, QModelIndex

class TokensModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    ValueRole = Qt.UserRole + 2

    _roles = {NameRole: b"name", ValueRole: b"value"}

    def __init__(self, parent=None):
        QAbstractListModel.__init__(self, parent)
        
        self.tokens = []

    def addToken(self, name, value):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.tokens.append((name, value))
        self.endInsertRows()


    @pyqtSlot(QModelIndex, float)
    def setValue(self, index, value):
        name, _ = self.tokens[index.row()]
        self.tokens[index.row()] = name, value

    def rowCount(self, parent=QModelIndex()):
        return len(self.tokens)

    def data(self, index, role=Qt.DisplayRole):
        try:
            name, value = self.tokens[index.row()]
        except IndexError:
            return QVariant()

        if role == self.NameRole:
            return name

        if role == self.ValueRole:
            return value

        return QVariant()
    
    def setData(self, index, value, role=Qt.EditRole):
        try:
            name, _ = self.tokens[index.row()]
        except IndexError:
            return False

        if value:
            self.tokens[index.row()] = (name, value)
            self.dataChanged.emit(index, index)
            return True
        
        return False

        


    def roleNames(self):
        return self._roles