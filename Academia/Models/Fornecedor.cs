﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Fornecedor
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public int CpfCnpj { get; set; }
        public string Email { get; set; }
        public string Telefone { get; set; }
        public string Endereço { get; set; }
        public string Descricao { get; set; }
    }
}
