########################################################################
###### STANDAR QT LIBRARIES
########################################################################
import sys
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
#from PyQt5.QtMultimedia import* # For use audio alarms
from PyQt5.QtChart import* #  pip install PyQtChart

########################################################################
###### SPECIAL LIBRARIES
########################################################################
import os
import random
import math
import serial.tools.list_ports

########################################################################
###### MAIN CLASS
########################################################################
class MainWindow(QObject):
	
	###### SIGNALS #####################################################
	# Signal Set Name
	setName = pyqtSignal(str)
	
	# Signal Set Name
	setPage = pyqtSignal(str)
	
	# Signal Set Port selected
	setCom = pyqtSignal(str)
	
	# Signal Set Data
	printTime = pyqtSignal(str)
	printDate = pyqtSignal(str)
	valueGauge = pyqtSignal(str)
	printHour = pyqtSignal(str)
	
	# Signal Visible
	isVisible = pyqtSignal(bool)
	
	# Open File To Text Edit
	readText = pyqtSignal(str)
	
	#setPuerto = pyqtSignal(object) ## NOT
	setPuerto = pyqtSignal(list)
	
	# Text String
	textField = ""
	
	def __init__(self, parent=None):
		super().__init__(parent)
		self.app = QApplication(sys.argv)
		self.app.setWindowIcon(QIcon("images/chip.ico"))
		self.engine = QQmlApplicationEngine(self)
		self.engine.rootContext().setContextProperty("backend", self)
		self.engine.load(QUrl("qml/main.qml"))

		#### SETUP CUSTOM ##############################################
		self.setupData()
		self.comSerialok = 0 
		#self.nodin = [0,0,0,0]
		self.iniClock()
		sys.exit(self.app.exec_())
	
	####################################################################
	###### CLOCK TIME
	####################################################################
	def iniClock(self):
		self.timer = QTimer()
		self.timer.timeout.connect(lambda: self.setTime())
		self.timer.start(1000)
	
	def setTime(self):
		current_time = QTime.currentTime()
		time = current_time.toString('HH:mm:ss')
		date =  QDate.currentDate().toString(Qt.ISODate)
		formatDate= 'Now is '+date+' '+time
		
		numTest = str(random.randint(10,100))
		self.valueGauge.emit(numTest)
		self.printTime.emit(formatDate)
		self.printDate.emit(date)
		self.printHour.emit(time)
		
	######   Setup data registers to transfer to QML ###################
	def setupData(self):
		self.adc1 = 0
		self.adc2 = 0
		self.adc3 = 0
		self.adc4 = 0
		self.adc5 = 0
		self.adc6 = 0
		self.adc7 = 0
		self.adc8 = 0
		self.digitalsIn0 = 0
		self.digitalsIn1 = 0
		self.digitalsIn2 = 0
		self.digitalsIn3 = 0
		self.digitalsIn4 = 0
		self.digitalsIn5 = 0
		self.digitalsIn6 = 0
		self.digitalsIn7 = 0
	
	######   Function Set Name To Page #################################
	@pyqtSlot(str)
	def namePage(self, pagex):
		self.setPage.emit(pagex)
		
	####################################################################
	# SELECT PORT & START COMMUNICATION
	####################################################################
	
	######   Description NAME HARDWARE COM PORTS  ######################
	@pyqtSlot(result=list)
	def personsList(self):
		return [port.device+" "+port.description for port in serial.tools.list_ports.comports()]
	
	######   Number COM port available  ################################
	@pyqtSlot(result=QVariant)
	def get_port_list_info(self):
		return [port.device for port in serial.tools.list_ports.comports()]
	
	######  Select COM PORT TO BE USED #################################
	@pyqtSlot(str,int)
	def setPortCom(self, port, speed):
		baudrate = int(speed)
		try: 
			self.ser = serial.Serial(
				port,
				baudrate,
				timeout=1,
				parity=serial.PARITY_NONE,
				stopbits=serial.STOPBITS_ONE,
				bytesize=serial.EIGHTBITS
			)
			if self.ser.is_open:
				#print("Set PORT COM :", port, speed)
				self.comSerialok = 1
				self.iniSampler()
		
		except :
			print("PUERTO SERIAL NO RESPONDE")
			#sys.exit(-1)
	
	###### Close serial port ###########################################
	@pyqtSlot(int)
	def closePort(self, value):
		self.comSerialok = 0 
		self.ser.close()
		#print("Successfully closed serial port")
	
	####################################################################
	###### SAMPLER DATA
	####################################################################
	def iniSampler(self):
		self.temporizador = QTimer()
		self.temporizador.timeout.connect(self.readData)
		self.temporizador.start(200)
	
	####################################################################
	# READ DATA FROM ARDUINO, ANALOGS AIN  & DIGITALS IN.
	####################################################################
	def readData(self):
		if self.comSerialok:
			data = self.ser.read(1)
			n = self.ser.inWaiting()
			while n:
				data = data + self.ser.read(n)
				n = self.ser.inWaiting()
				####### READ ANALOGS INPUTS ARDUINO
				st1=data[0]*256+data[1]
				st2=data[2]*256+data[3]
				st3=data[4]*256+data[5]
				st4=data[6]*256+data[7]
				st5=data[8]*256+data[9]
				st6=data[10]*256+data[11]
				st7=data[12]*256+data[13]
				st8=data[14]*256+data[15]
				#print (st1," ",st2," ",st3," ",st4)
				self.adc1 = st1
				self.adc2 = st2
				self.adc3 = st3
				self.adc4 = st4
				self.adc5 = st5
				self.adc6 = st6
				self.adc7 = st7
				self.adc8 = st8
				
				######## READ DIGITAL INPUTS ARDUINO
				Din1=data[16]*256+data[17]
				Din2=data[18]*256+data[19]
				Din3=data[20]*256+data[21]
				Din4=data[22]*256+data[23]
				Din5=data[24]*256+data[25]
				Din6=data[26]*256+data[27]
				Din7=data[28]*256+data[29]
				Din8=data[30]*256+data[31]
				#print (Din1," ",Din2," ",Din3," ",Din4)

				# check the bit 1 for true and 0 false
				self.digitalsIn0 = Din1&1
				self.digitalsIn1 = Din2&1
				self.digitalsIn2 = Din3&1
				self.digitalsIn3 = Din4&1
				self.digitalsIn4 = Din5&1
				self.digitalsIn5 = Din6&1
				self.digitalsIn6 = Din7&1
				self.digitalsIn7 = Din8&1
	
	####################################################################
	# REFERENCE TIME FOR GRAPHICS : VOLATILE CHART
	####################################################################
	@pyqtSlot(result=int)
	def get_tiempo(self):
		date_time = QDateTime.currentDateTime()
		unixTIME = date_time.toSecsSinceEpoch()
		#unixTIMEx = date_time.currentMSecsSinceEpoch()
		return unixTIME
	
	####################################################################
	#  Set ON/OFF output  FOR ARDUINO 
	####################################################################
	@pyqtSlot('int','QString')
	def setPinoutput(self, pin, value):
		dataled=str(pin)+value
		#print (dataled)
		if self.comSerialok:
			self.ser.write(dataled.encode())
		else :
			pass
			#print("Set PIN OUTPUT :", pin, value)
	
	####################################################################
	# Set PWM output FOR ARDUINO 
	####################################################################
	@pyqtSlot('QString','QString')
	def setPwm(self, pin, value):
		datapinpwm =pin+value
		#print (datapinpwm)
		if self.comSerialok:
			self.ser.write((pin+value).encode())
		else:
			pass
			#print("Set PWM: PIN", pin, value)
	
	####################################################################
	# SEND  DATA  FROM PYTHON   TO QML: DIGITAL INPUTS
	####################################################################
	@pyqtSlot(result=int)
	def get_din0(self):
		return self.digitalsIn0
	
	@pyqtSlot(result=int)
	def get_din1(self):
		return self.digitalsIn1
	
	@pyqtSlot(result=int)
	def get_din2(self):
		return self.digitalsIn2
	
	@pyqtSlot(result=int)
	def get_din3(self):
		return self.digitalsIn3
	
	@pyqtSlot(result=int)
	def get_din4(self):
		return self.digitalsIn4
	
	@pyqtSlot(result=int)
	def get_din5(self):
		return self.digitalsIn5
	
	@pyqtSlot(result=int)
	def get_din6(self):
		return self.digitalsIn6
	
	@pyqtSlot(result=int)
	def get_din7(self):
		return self.digitalsIn7
	
	####################################################################
	# SEND  DATA  FROM PYTHON : ANALOG INPUTS
	####################################################################
	@pyqtSlot(result=float)
	def get_adc1(self):
		return self.adc1
		
	@pyqtSlot(result=float)
	def get_adc2(self):
		return self.adc2
		
	@pyqtSlot(result=float)
	def get_adc3(self):
		return self.adc3
	
	@pyqtSlot(result=float)
	def get_adc4(self):
		return self.adc4
	
	@pyqtSlot(result=float)
	def get_adc5(self):
		return self.adc5
	
	@pyqtSlot(result=float)
	def get_adc6(self):
		return self.adc6
	
	@pyqtSlot(result=float)
	def get_adc7(self):
		return self.adc7
	
	@pyqtSlot(result=float)
	def get_adc8(self):
		return self.adc8

	####################################################################
	# SEND  DATA FROM PYTHON TO CHART CALCULATED FUNCTION (CSV, RANDOM)
	####################################################################
	@pyqtSlot(QObject)
	def update0(self, series):
		series.clear()
		for i in range(128):
			series.append(i, 45*(math.sin(0.05*3.1416*i))+ random.random()*8)
			
	@pyqtSlot(QObject)
	def update1(self, series):
		series.clear()
		for i in range(128):
			series.append(i, 20*(math.sin(0.075*3.1416*i))+ random.random()*15)
	
	@pyqtSlot(QObject)
	def update2(self, series):
		series.clear()
		for i in range(128):
			series.append(i, 25*(math.sin(0.105*3.1416*i))+ random.random()*12)
			
	@pyqtSlot(QObject)
	def update3(self, series):
		series.clear()
		for i in range(128):
			series.append(i, 30*(math.sin(0.035*3.1416*i))+ random.random()*17)

	####################################################################
	# FUNCTIONS FOR PAGE SETTINGS
	####################################################################
	
	######   Function Set Name To Label  ###############################
	@pyqtSlot(str)
	def welcomeText(self, name):
		self.setName.emit("Welcome, " + name)
	
	######  Show / Hide Rectangle ######################################
	@pyqtSlot(bool,int)
	def showHideRectangle(self, isChecked, number):
		#print("Is rectangle visible: ", isChecked, number)
		self.isVisible.emit(isChecked)
	

####################################################################
###### MAIN ROUTINE
####################################################################
if __name__ == '__main__':
	main = MainWindow()



















































































