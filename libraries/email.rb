class Email

  def self.reset(to, password)
    body = ""
    body << "<p>Resume Tool Account</p>"
    body << "<p>Your Password: #{password}</p>"

    Pony.mail(headers: { 'Content-Type' => 'text/html' },
                   to: to,
                 from: 'no-reply@careertrain.com',
              subject: 'Resume Tool Account Password',
                 body: body)
  end
  
  def self.requestcd2 school_name, school_address1, school_address2, school_city, school_state, school_zip, first_name, last_name, email, phone

    body = ''
    body << "<h4>Request CD2 Program from Educator</h4>"
    body << "<p>School Name: #{school_name}</p>"
    body << "<p>#{school_address1}</p>"
    body << "<p>#{school_address2}</p>"
    body << "<p>#{school_city} #{school_state} #{school_zip}</p>"
    body << "<p>Contact: #{first_name} #{last_name}</p>"
    body << "<p>Email: #{email}</p>"
    body << "<p>Phone: #{phone}</p>"
    

    Pony.mail(
      headers: { 'Content-Type' => 'text/html' },
      to: 'info@careertrain.com, skiptaylor101@gmail.com',
      from: 'no-reply@careertrain.com',
      subject: 'Request CD2 Program from Educator',
      body: body
    )
  end
  
end
