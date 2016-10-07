# RaspberryPi-PC-tunneling
Breve guida su come condividere la connessione internet tra un PC (connesso via wifi) e un Raspberry connesso via ethernet direttamente al PC


Per prima cosa è importante che il PC sia connesso ad internet via wifi con un IP diverso da quello che useremo (es 192.168.0.2).
Controlliamo l'IP col comando `ifconfig`. A questo punto diamo sia al pc un IP statico come ad esempio

* IP PC -> 192.168.10.10
* IP RPI -> 192.168.10.22

###E' importante che sul pc non sia impostato un Gateway

###E' importante che sul RPI sia impostato come Gateway l'IP del PC

Connettiamo con un cavo i due dispositivi e la connessione dovrebbe funzionare!
Come test possiamo usare `ping IP PC` dal RPI e `ping IP RPI` dal PC


A questo punto possiamo eseguire uno script che reindirizza le chiamate del RPI dalla ethernet alla wireless direttamente

Per fare questo eseguiamo **sul PC** lo script server.sh  con:

```sudo sh server.sh``` 


Le tabelle di routing (risultato di `route -n`) dovrebbero apparire più o meno così:

```
PC
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG    600    0        0 wlp2s0
192.168.0.0     0.0.0.0         255.255.255.0   U     600    0        0 wlp2s0
192.168.10.0    0.0.0.0         255.255.255.0   U     100    0        0 enp1s0f1

RaspberryPI
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG    0      0        0 wlan0
192.168.0.0     0.0.0.0         255.255.255.0   U     0      0        0 wlan0```


Come si vede le interfacce hanno nomi diversi!
Il file **server.sh** allegato è esattamente per la configurazione sopra descritta!

come si vede il gateway nello script deve essere quello della connessione internet (quindi il wifi).

La variabile `prv_int` (private interface) rappresenta la scheda del PC a cui è collegato il RaspberryPI
La variabile `pub_int` (public interface) rappresenta la scheda del PC connessa ad internet.

Buona fortuna!!
