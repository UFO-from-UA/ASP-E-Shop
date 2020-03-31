using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Owen.Models
{
    public class BasketModalClient
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Capcha { get; set; }
        public string Message { get; set; }
        public bool EmailToClient { get; set; }

        public override string ToString()
        {
            return $"{Email} : {LastName} {FirstName} {SecondName} {Phone}";
        }
        public override bool Equals(object Client)
        {
            return (Client as BasketModalClient).Email == this.Email?  true: false;
            //return base.Equals(obj);
        }

    }
}