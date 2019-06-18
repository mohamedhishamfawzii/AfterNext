# AfterNext

After next Football arena’s  scheduling  scenario :

Every arena has 8 tickets per day representing 8 hours of playing  (ticket 6 , 7 , 8pm…,2 am) 

Every ticket has a QRcode

If u want to reserve 1 hour you will choose the arena and request a ticket  (give ur mobile number, name)

The admin will see that u requested one ticket and will approve and generate QR code for the ticket

When u as a player requests a ticket , there will be a binding requests tab when the admin approves, when u as aplayer  tap 3la el request the QR will appear 


Admin :

1st tab
- Table that has all the tickets requests and it’s status
- feh search by player number 3shan yshof el history bta3 el player 
- in the cell you will have option to approve or delcine 
    - if approved a QR will be generated w yt save fl database
2nd tab
- scan tab to scan the QR code 
- byd5al el arenas awl mara yft7 el app (name w price per ticket )



Player :
 - table of all the arenas with a book button lma ydoso yft7lo tab y2olo eh el sa3at el ma7goza w eh ely la2 w y5tar 3ayz y7gz sa3a rakm kam
- tab of requested tickets when approved hyzharlo el qr code ely hywareh lyl admin ama ywsl


Model using Fire Store :

Admin 
 login with google 
- arenas[ ]

Arena 
  - name 
  - location
  -  id
- price per ticket
- tickets[] history bta3 kol el tickets ely et7gzt
- array of boolean feh 6 bool kol wa7d by represent ticket  [] byb2a false kol youm el sa3a 3AM

Ticket
  -Arena_id
  - Arena Name
- player name
- player mobile
- if issued status (approved , declined)
- After it’s day status (Played , player didn’t show )
- Notes ( lw el 3yal kant mohz2a masln ) 
