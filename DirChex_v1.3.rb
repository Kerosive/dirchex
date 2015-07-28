require 'rubygems'
require 'wx'
require 'mechanize'
  include Wx
  
  Button_Browse = 0
  Button_Exit = 1
  Button_Get = 2
  Button_Put = 3
  Button_Putbrowse = 4
    
  class DirChexFrame < Frame
    def initialize
       super(nil, -1, "DirChex_v1.3", Point.new(100, 100), Size.new(550, 560))

      #This section defines the tabs and what to do when selected       
       
       tab = Notebook.new(self, -1, Point.new(1,1), Size.new(88,24))        
      
       get_panel = Panel.new(tab)
       get_panel.set_background_colour(BLACK)
      
       put_panel = Panel.new(tab)
       put_panel.set_background_colour(BLACK)    
      
       tab.add_page(get_panel, "GET", TRUE) 
       tab.add_page(put_panel, "PUT", FALSE)
         
       #End of tab section
       
       #This bit of code makes sure we have panels to work with ;-)
      
       def panel_1
       Panel.new(self, -1)
       end
       
       #End Panel section
      
       #This section makes a menu bar AND a status bar which echoes words of your choice to the user when highlighting or using program
       
       menuBar = MenuBar.new()
       menu1 = Menu.new()
       menu1.append(101, "&Close", "Close DirChex")
       menuBar.append(menu1, "&File")
             
       menu2 = Menu.new()
       menu2.append(201, "&Help", "Help!!!")
       menu2.append(202, "&About", "About Us")
       menuBar.append(menu2, "&Help")
       set_menu_bar(menuBar)
       
       create_status_bar()
       set_status_text("By cktricky & k3r0s1n3")
      
       #End of menu bar section
      
       #This section creates the layout of the buttons, checkboxes, text, etc. for the get_panel
         
      sizer = BoxSizer.new(VERTICAL)
                
            dirText = StaticText.new(get_panel, -1, "Choose your input file", Point.new(150, 30))
            dirText.set_foreground_colour(GREEN)
            font = Font.new(12, MODERN, NORMAL, NORMAL)
            dirText.set_font(font)
            @text = TextCtrl.new(get_panel, -1, "", Point.new(80, 60), Size.new(294, 20))
            @text.set_background_colour(BLACK)
            @text.set_foreground_colour(GREEN)
                  
            directoryButton = Button.new(get_panel, Button_Browse, "Browse", Point.new(376, 59))
            directoryButton.set_background_colour(BLACK)
            directoryButton.set_foreground_colour(GREEN)
            
            @chkIP = CheckBox.new(get_panel, -1, "127.0.0.1 (Default Setting)", Point.new(80,110))
            @chkIP.set_foreground_colour(GREEN) 
      
            
            @ip = TextCtrl.new(get_panel, -1, "", Point.new(315, 106), Size.new(30,20))
            @ip.set_background_colour(BLACK)
            @ip.set_foreground_colour(GREEN)
            @ip.set_max_length(3)
            
            @ip1 = TextCtrl.new(get_panel, -1, "", Point.new(350, 106), Size.new(30,20))
            @ip1.set_background_colour(BLACK)
            @ip1.set_foreground_colour(GREEN)
            @ip1.set_max_length(3)
            
            @ip2 = TextCtrl.new(get_panel, -1, "", Point.new(385, 106), Size.new(30,20))
            @ip2.set_background_colour(BLACK)
            @ip2.set_foreground_colour(GREEN)
            @ip2.set_max_length(3)
            
            @ip3 = TextCtrl.new(get_panel, -1, "", Point.new(420, 106), Size.new(30,20))
            @ip3.set_background_colour(BLACK)
            @ip3.set_foreground_colour(GREEN)
            @ip3.set_max_length(3)
            
            @chkPort = CheckBox.new(get_panel, -1, "8080 (Default Setting)", Point.new(80,140))
            @chkPort.set_foreground_colour(GREEN)
            
            @port = TextCtrl.new(get_panel, -1, "", Point.new(361, 136), Size.new(43,20))
            @port.set_background_colour(BLACK)
            @port.set_foreground_colour(GREEN)
            @port.set_max_length(5)
            
            orText = StaticText.new(get_panel, -1, "OR=>", Point.new(252, 120))
            orText.set_foreground_colour(GREEN)
            orText.set_font(font)
            
            agentText = StaticText.new(get_panel, -1, "Choose your user agent", Point.new(180, 210))
            agentText.set_foreground_colour(GREEN)
            font1 = Font.new(10, MODERN, NORMAL, NORMAL)
            agentText.set_font(font1)
            
            list = ["Windows IE 6", "Windows IE 7", "Windows Mozilla", "Mac Safari", "Mac FireFox", "Mac Mozilla", "Linux Mozilla", "Linux Konqueror", "Mechanize"]
            @userAgent = ComboBox.new(get_panel, -1, "Choose One", Point.new(203, 240), Size.new(120, 20), list, CB_READONLY)
            @userAgent.set_background_colour(BLACK)
            @userAgent.set_foreground_colour(GREEN)
            
            chexButton = Button.new(get_panel, Button_Get, "Get  it!", Point.new(229, 380))
            chexButton.set_background_colour(BLACK)
            chexButton.set_foreground_colour(GREEN)
            
            exitButton = Button.new(get_panel, Button_Exit, "Exit", Point.new(229, 410))
            exitButton.set_background_colour(BLACK)
            exitButton.set_foreground_colour(GREEN)
            
            #End of the visual layout section for the get_panel
            
            #This section creates the layout of the buttons, checkboxes, text, etc. for the put_panel
            
            putdirText = StaticText.new(put_panel, -1, "Choose your input file", Point.new(150, 10))
            putdirText.set_foreground_colour(GREEN)            
            putdirText.set_font(font)
            @puttext = TextCtrl.new(put_panel, -1, "", Point.new(80, 40), Size.new(294, 20))
            @puttext.set_background_colour(BLACK)
            @puttext.set_foreground_colour(GREEN)
            
            putdirectoryButton = Button.new(put_panel, Button_Putbrowse, "Browse", Point.new(376, 39))
            putdirectoryButton.set_background_colour(BLACK)
            putdirectoryButton.set_foreground_colour(GREEN)
      
            @putchkIP = CheckBox.new(put_panel, -1, "127.0.0.1 (Default Setting)", Point.new(80,90))
            @putchkIP.set_foreground_colour(GREEN) 

      
            @putip = TextCtrl.new(put_panel, -1, "", Point.new(315, 86), Size.new(30,20))
            @putip.set_background_colour(BLACK)
            @putip.set_foreground_colour(GREEN)
            @putip.set_max_length(3)
      
            @putip1 = TextCtrl.new(put_panel, -1, "", Point.new(350, 86), Size.new(30,20))
            @putip1.set_background_colour(BLACK)
            @putip1.set_foreground_colour(GREEN)
            @putip1.set_max_length(3)
      
            @putip2 = TextCtrl.new(put_panel, -1, "", Point.new(385, 86), Size.new(30,20))
            @putip2.set_background_colour(BLACK)
            @putip2.set_foreground_colour(GREEN)
            @putip2.set_max_length(3)
      
            @putip3 = TextCtrl.new(put_panel, -1, "", Point.new(420, 86), Size.new(30,20))
            @putip3.set_background_colour(BLACK)
            @putip3.set_foreground_colour(GREEN)
            @putip3.set_max_length(3)
      
            @putchkPort = CheckBox.new(put_panel, -1, "8080 (Default Setting)", Point.new(80,120))
            @putchkPort.set_foreground_colour(GREEN)
      
            @putport = TextCtrl.new(put_panel, -1, "", Point.new(361, 106), Size.new(43,20))
            @putport.set_background_colour(BLACK)
            @putport.set_foreground_colour(GREEN)
            @putport.set_max_length(5)
      
            putorText = StaticText.new(put_panel, -1, "OR=>", Point.new(252, 100))
            putorText.set_foreground_colour(GREEN)
            putorText.set_font(font)
            
            putfileText = StaticText.new(put_panel, -1, "Name of the file to PUT", Point.new(180, 150))
            putfileText.set_foreground_colour(GREEN)
            putfileText.set_font(font1)   
            @puttextfile = TextCtrl.new(put_panel, -1, "", Point.new(180, 170), Size.new(170, 20))
            @puttextfile.set_background_colour(BLACK)
            @puttextfile.set_foreground_colour(GREEN)

                        
            putcontentText = StaticText.new(put_panel, -1, "Text within the file", Point.new(180, 200))
            putcontentText.set_foreground_colour(GREEN)
            putcontentText.set_font(font1)  
            @putfilecontent = TextCtrl.new(put_panel, -1, "", Point.new(180, 220), Size.new(170, 20))
            @putfilecontent.set_background_colour(BLACK)
            @putfilecontent.set_foreground_colour(GREEN)
            
            putcontenttypeText = StaticText.new(put_panel, -1, "Choose content-type / MIME Property", Point.new(140, 260))
            putcontenttypeText.set_foreground_colour(GREEN)            
            putcontenttypeText.set_font(font1)
            
            contenttypelist = ["application/x-www-form-urlencoded","application/EDI-X12","application/EDIFACT","application/javascript","application/octet-stream",
            "application/ogg","application/pdf","application/xhtml+xml","application/xml-dtd","application/json","application/zip","audio/basic","audio/mp4","audio/mpeg",
            "audio/ogg","audio/vorbis","audio/x-ms-wma","audio/vnd.rn-realaudio","audio/vnd.wave","image/gif","image/jpeg","image/png","image/svg+xml","image/tiff",
            "image/vnd.microsoft.icon","message/http", "multipart/mixed","multipart/alternative","multipart/related","multipart/form-data","multipart/signed",
            "multipart/encrypted","text/css","text/csv","text/html","text/javascript","application/javascript","text/plain","text/xml"]
            @contenttypeText = ComboBox.new(put_panel, -1, "Choose one", Point.new(203, 290), Size.new(120,20), contenttypelist, CB_READONLY)
            @contenttypeText.set_background_colour(BLACK)
            @contenttypeText.set_foreground_colour(GREEN)
            
            putagentText = StaticText.new(put_panel, -1, "Choose your user agent", Point.new(180, 320))
            putagentText.set_foreground_colour(GREEN)            
            putagentText.set_font(font1)
      
            putlist = ["Windows IE 6", "Windows IE 7", "Windows Mozilla", "Mac Safari", "Mac FireFox", "Mac Mozilla", "Linux Mozilla", "Linux Konqueror", "Mechanize"]
            @putuserAgent = ComboBox.new(put_panel, -1, "Choose One", Point.new(203, 350), Size.new(120, 20), putlist, CB_READONLY)
            @putuserAgent.set_background_colour(BLACK)
            @putuserAgent.set_foreground_colour(GREEN)
      
            putButton = Button.new(put_panel, Button_Put, "Put  it!", Point.new(229, 390))
            putButton.set_background_colour(BLACK)
            putButton.set_foreground_colour(GREEN)
      
            putexitButton = Button.new(put_panel, Button_Exit, "Exit", Point.new(229, 420))
            putexitButton.set_background_colour(BLACK)
            putexitButton.set_foreground_colour(GREEN)
            
          #End of the visual layout section for the put_panel
            
      
      show(true)
      
      
      
      #This section contains the event buttons/menu and which method will be called when you use them
       
      evt_button(Button_Browse){inputFile}
      evt_button(Button_Get) {dirChex}
      evt_button(Button_Exit) {onExit}
      evt_button(Button_Put)  {putDir}
      evt_button(Button_Putbrowse) {putinputFile}
      evt_menu(101) {|event| menu_101(event)}
      evt_menu(201) {|event| menu_201(event)}
      evt_menu(202) {|event| menu_202(event)}  
  
      #End of the event section  
  end

  
#This section defines the pop-up to choose a filename to read and the filename itself the list of URLs from and will be used as the value for the (url_file) portion    
def inputFile
    frame = Frame.new
    dlg = FileDialog.new(frame, "Choose an input file:")
    dlg.show_modal() == ID_OK
    @text.write_text(dlg.get_path())
end  

def putinputFile
  frame = Frame.new
  putdlg = FileDialog.new(frame, "Choose and input file:")
  putdlg.show_modal() == ID_OK
  @puttext.write_text(putdlg.get_path())
end

def url_file
  url_file = @text.get_value
end

def purl_file
  purl_file = @puttext.get_value
end

#End of the filename decision section

#This section defines the two pieces necessary for a successful PUT 1) pfile (name of file to put) 2) ptext (text within this file)

def pfile
  pfile = @puttextfile.get_value
end

def ptext
  ptext = @putfilecontent.get_value
end

#End of the pfile/ptext section


#This section defines the proxy IP information for input as "addr" in the agent.set_proxy portion
def addrTextChoice
addrTextChoice = @ip.get_range(0,255)+'.'+@ip1.get_range(0,255)+'.'+@ip2.get_range(0,255)+'.'+@ip3.get_range(0,255)
end  

def paddrTextChoice
  paddrTextChoice = @putip.get_range(0,255)+'.'+@putip1.get_range(0,255)+'.'+@putip2.get_range(0,255)+'.'+@putip3.get_range(0,255)
end

def addrBoxChoice
  addrBoxChoice = @chkIP
  if @chkIP.is_checked == true
  addrBoxChoice = '127.0.0.1'
  elsif @chkIP.is_checked == false
  addrBoxChoice == nil    
  end
end

def paddrBoxChoice
  paddrBoxChoice = @putchkIP
  if @putchkIP.is_checked == true
  paddrBoxChoice = '127.0.0.1'  
  elsif @putchkIP.is_checked == false
  paddrBoxChoice == nil
  end
end

def addr
  if addrBoxChoice == '127.0.0.1'
  addr = '127.0.0.1'
  else
    addr = addrTextChoice
  end  
end

def paddr
  if paddrBoxChoice == '127.0.0.1'
    paddr = '127.0.0.1'
  else
    paddr = paddrTextChoice
  end  
end

#End of proxy IP information section

#This section defines the proxy Port information for input as "port_num" in the agent.set_proxy portion

def portTextChoice
portTextChoice = @port.get_range(0, 65535)
end

def pportTextChoice
  pportTextChoice = @putport.get_range(0, 65535)
end

def portBoxChoice
  portBoxChoice = @chkPort
  if @chkPort.is_checked == true
    portBoxChoice = '8080'
  elsif @chkPort.is_checked == false
    addrBoxChoice == nil
  end
end

def pportBoxChoice
  pportBoxChoice = @putchkPort
  if @putchkPort.is_checked == true
    pportBoxChoice = '8080'
  elsif @putchkPort.is_checked == false
    paddrBoxChoice == nil
  end
end

def port_num
if portBoxChoice == '8080'
  port_num = '8080'
else 
  port_num = portTextChoice
 end  
end

def pport_num
  if pportBoxChoice == '8080'
    pport_num = '8080'
  else
    pport_num = pportTextChoice
  end
end

#End of proxy Port information section

#This section is for the content-type value included in the headers when making a request

def contentType
  contentType = @contenttypeText.get_value
end

#End of content-type section

#This section defines what the user agent value will be for the user_agent_alias value  

def uaChoice
  uaChoice = @userAgent.get_value
end

def puaChoice 
  puaChoice = @putuserAgent.get_value
end  

#End of user agent decision section

#This section defines what will happen if the user utilizes one of the corresponding evt_button/evt_menu/etc 

def onExit
  close(true)
end  

def menu_101(event)
    close(true)
end

def menu_201(event)
  frame = Frame.new
  dlg = MessageDialog.new(frame, "Visit http://k3r0s1n3.blogspot.com for help related information", "DirChex_v1.1 Help", OK )
  dlg.show_modal()  
end

def menu_202(event)
 frame = Frame.new
 dlg = MessageDialog.new(frame, "Greets from k3r0s1n3 & cktricky!!\n\n Visit k3r0s1n3:\n\n http://twitter.com/k3r0s1n3\n http://k3r0s1n3.blogspot.com\n\n and cktricky:\n\n http://twitter.com/cktricky\n http://cktricky.blogspot.com", "Creators of DirChex_v1.1", OK )
 dlg.show_modal()
end

#End of evt menu/button definition section

end



#This section is for what we call the "engine" of the app. The page method is what is requesting the URLs thru the proxy in an automated fashion

def page
agent = WWW::Mechanize.new
agent.ca_file = false
agent.verify_callback = false
agent.user_agent_alias = uaChoice
agent.set_proxy(addr, port_num)
agent.keep_alive = false
  list = IO.foreach(url_file) do |line|
    begin 
   agent.get(line) 
    rescue WWW::Mechanize::ResponseCodeError
      puts "Response Code Error"
    rescue Timeout::Error
      puts "Keep-Alive timeout"
   rescue  Errno::ECONNABORTED 
     end
  end
end

def putpage
  pagent = WWW::Mechanize.new
  pagent.ca_file = false
  pagent.verify_callback = false
  pagent.user_agent_alias = puaChoice
  pagent.set_proxy(paddr, pport_num)
  pagent.keep_alive = false
  plist = IO.foreach(purl_file) do |line|
   begin
      pagent.put(line.gsub(/\n/,'') + pfile, ptext , :headers => {'Content-Type' => contentType})
    rescue WWW::Mechanize::ResponseCodeError
      puts "Response Code Error"  
    rescue Timeout::Error
      puts "Keep-Alive timeout"
    rescue Errno::ECONNABORTED
    rescue URI::InvalidURIError
    end
  end
 end 


#End of the page method related section

#This section is where we begin to define most of our error handling controls
def runerrDialog
  frame = Frame.new
  dlg = MessageDialog.new(frame, " Enter some data!\n\n If you did enter some data and are still getting this error, choose a\n User Agent\n\n OR\n\n The input file is not in the correct format (go to the help menu)", "Your doing it wrong", OK | ICON_ERROR )
  dlg.show_modal()
end

def sockerrDialog
  frame = Frame.new
  dlg = MessageDialog.new(frame, " 1) Your proxy is not up\n 2) Your Proxy IP or Port Number was entered incorrectly\n 3) Something else...seek shelter", "Uh-oh", OK | ICON_ERROR )
  dlg.show_modal()
end

def enoentErrDialog 
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  You may have entered the input file name or location incorrectly\n\n AND\n\n You may have just killed a kitten", "Oh the horror!", OK | ICON_ERROR)
  dlg.show_modal()
end

def einvalErrDialog 
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  Usually this error occurs because an input file wasn't specified", "Doh!", OK | ICON_ERROR)
  dlg.show_modal()
end

def etimedoutErr
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  Normally this error occurs when one of the four octets which\n  defines the proxy IP is null or garbage data", "Seriously!!", OK | ICON_ERROR)
  dlg.show_modal()
end

def enotconnErr
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  Usually this error occurs because a port wasn't specified", "Dang!!!", OK | ICON_ERROR)
  dlg.show_modal()
end

def econnrefusedErr   
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  Either your proxy is NOT running or it hates us", "Chex that proxy", OK | ICON_ERROR)
  dlg.show_modal()
end

def eaddrnotavailErr
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  This error generally occurs with WinXP and a port value not given", "Chex that port", OK | ICON_ERROR)
  dlg.show_modal()
end

def invaliduriErr
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  This error generally occurs with WinXP and an improperly formatted input file, reference Help Menu", "Chex that file", OK | ICON_ERROR)
  dlg.show_modal()
end

def econnresetErr  
  frame = Frame.new
  dlg = MessageDialog.new(frame, "  Looks to be something is running on the port you specified but\n  it isn't a proxy", "You tried to bend the spoon", OK | ICON_ERROR)
  dlg.show_modal()
end

#Error handling section ends

#This section starts the "engine" so-to-speak while ensuring errors are caught. The evt_button "Get it!", when pushed, runs this method

def dirChex
  Thread.new do
  begin
  page 
  rescue RuntimeError
    runerrDialog
  rescue SocketError
    sockerrDialog
  rescue Errno::EINVAL
    einvalErrDialog
  rescue Errno::ENOENT
    enoentErrDialog
  rescue Errno::ETIMEDOUT
    etimedoutErr
  rescue Errno::ENOTCONN
    enotconnErr
  rescue Errno::ECONNREFUSED
    econnrefusedErr 
  rescue Errno::EADDRNOTAVAIL
    eaddrnotavailErr
  rescue URI::InvalidURIError
    invaliduriErr
  rescue Errno::ECONNRESET
  econnresetErr 
  rescue getaddrinfo
  end
end
end


def putDir  
  Thread.new do
  begin
    putpage
  rescue RuntimeError
    runerrDialog
  rescue SocketError
    sockerrDialog
  rescue Errno::EINVAL
    einvalErrDialog
  rescue Errno::ENOENT
    enoentErrDialog
  rescue Errno::ETIMEDOUT
    etimedoutErr
  rescue Errno::ENOTCONN
    enotconnErr
  rescue Errno::ECONNREFUSED
    econnrefusedErr 
  rescue Errno::EADDRNOTAVAIL
    eaddrnotavailErr
  rescue URI::InvalidURIError
    invaliduriErr
  rescue Errno::ECONNRESET
    econnresetErr
  rescue getaddrinfo
  end
end
end

#End of the dirChex method definition  
  
#This class starts the DirChexFrame class which initializes the main program

 class DirChexApp < App
    def on_init
     DirChexFrame.new
      t = Timer.new(self, 10)
      evt_timer(10) { Thread.pass }
      t.start(1)
    end
  end

#End of DirChexApp defintion   
  
#This section simply turns the ignition 
    
DirChexApp.new.main_loop