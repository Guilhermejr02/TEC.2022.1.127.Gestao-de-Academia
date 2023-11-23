﻿using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class FornecedorDAL
    {
        public void Inserir(Fornecedor _fornecedor)
        {
            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = cn.CreateCommand();
                cmd.CommandText = @"INSERT INTO Fornecedor(Nome, CpfCnpj, Email, Telefone, Descricao,
                                    Rua, CEP, Bairro, Complemento, NumeroCasa, Pais, Cidade, Estado) 
                                    VALUES (@Nome, @CpfCnpj, @Email, @Telefone, @Descricao,
                                    @Rua, @CEP, @Bairro, @Complemento, @NumeroCasa, @Pais, @Cidade, @Estado)";

                cmd.CommandType = System.Data.CommandType.Text;
                PreencherParametros(_fornecedor, cmd, Operacao.Inserir);

                cmd.Connection = cn;
                cn.Open();

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar inserir um Fornecedor no banco de dados.", ex) { Data = { { "Id", 15 } } };
            }
            finally
            {
                cn.Close();
            }
        }
       

        public List<Fornecedor> BuscarTodos()
        {
            List<Fornecedor> fornecedorList = new List<Fornecedor>();
            Fornecedor fornecedor = new Fornecedor();
            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                cmd.CommandText = @"SELECT Id, Nome, CpfCnpj, Email, Telefone, Descricao,
                                    Rua, CEP, Bairro, Complemento, NumeroCasa";
                cmd.CommandType = System.Data.CommandType.Text;

                cn.Open();
                using (SqlDataReader rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        fornecedor = PreencherObjeto(rd);
                        fornecedorList.Add(fornecedor);
                    }
                }
                return fornecedorList;
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar buscar Fornecedor no banco de dados", ex) { Data = { { "Id", 16 } } };
            }
            finally
            {
                cn.Close();
            }
        }

        

        public List<Fornecedor> BuscarPorNome(string _nome)
        {
            List<Fornecedor> fornecedorList = new List<Fornecedor>();
            Fornecedor fornecedor = new Fornecedor();
            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                cmd.CommandText = @"SELECT Id, Nome, CpfCnpj, Email, Telefone, Descricao,
                                    Rua, CEP, Bairro, Complemento, NumeroCasa 
                                    FROM Cliente WHERE Nome LIKE @Nome";
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@Nome", "%" + _nome + "%");

                cn.Open();
                using (SqlDataReader rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        fornecedor = new Fornecedor();
                        PreencherObjeto(rd);

                        fornecedorList.Add(fornecedor);
                    }
                }
                return fornecedorList;
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar buscar Fornecedor por nome no banco de dados", ex) { Data = { { "Id", 17 } } };
            }
            finally
            {
                cn.Close();
            }
        }
        public Fornecedor BuscarPorCpfCnpj(string _CpfCnpj)
        {
            Fornecedor fornecedor = new Fornecedor();
            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                cmd.CommandText = @"SELECT Id, Nome, CpfCnpj, Email, Telefone, Descricao,
                                    Rua, CEP, Bairro, Complemento, NumeroCasa 
                                    FROM Fornecedor WHERE CpfCnpj = @CpfCnpj";
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@CpfCnpj", _CpfCnpj);

                cn.Open();
                using (SqlDataReader rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {
                        fornecedor = new Fornecedor();
                        PreencherObjeto(rd);
                    }
                }
                return fornecedor;
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar buscar clientes por CPF no banco de dados", ex) { Data = { { "Id", 19 } } };
            }
            finally
            {
                cn.Close();
            }
        }
        public void Alterar(Fornecedor _fornecedor)
        {

            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = cn.CreateCommand();
                cmd.CommandText = @"UPDATE Fornecedor SET 
                                        Nome = @Nome, 
                                        CPF = @CpfCnpj, 
                                        Email = @Email, 
                                        Telefone = @Telefone 
                                        Rua= @Rua
                                        Descricao = @Descricao
                                        CEP = @CEP
                                        Bairro = @Bairro
                                        Cidade = @Cidade
                                        Estado = @Estado
                                        NumeroCasa = @NumeroCasa
                                        Pais = @Pais
                                        WHERE Id = @Id";
                cmd.CommandType = System.Data.CommandType.Text;

                PreencherParametros(_fornecedor, cmd, Operacao.Alterar);

                cmd.Connection = cn;
                cn.Open();

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao tentar alterar Fornecedor no banco de dados", ex) { Data = { { "Id", 20 } } };
            }
            finally
            {
                cn.Close();
            }
        }
        public void Excluir(int _id)
        {

            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = cn.CreateCommand();
                cmd.CommandText = @"DELETE FROM Fornecedor WHERE id = @id";
                cmd.CommandType = System.Data.CommandType.Text;

                PreencherParametros(cmd, _id);

                cmd.Connection = cn;
                cn.Open();

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar excluir Fornecedor no banco de dados.", ex) { Data = { { "Id", 21 } } };
            }
            finally
            {
                cn.Close();
            }
        }
        public Fornecedor BuscarPorId(int _id)
        {
            Fornecedor fornecedor = new Fornecedor();
            SqlConnection cn = new SqlConnection(Conexao.StringDeConexao);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                cmd.CommandText = @"SELECT Id, Nome, CpfCnpj, Email, Telefone, Descricao,
                                    Rua, CEP, Bairro, Complemento, NumeroCasa 
                                    FROM Fornecedor WHERE Id = @Id";
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@Id", _id);

                cn.Open();
                using (SqlDataReader rd = cmd.ExecuteReader())
                {
                    if (rd.Read())
                    {
                        fornecedor = new Fornecedor();
                        PreencherObjeto(rd);
                    }
                }
                return fornecedor;
            }
            catch (Exception ex)
            {
                throw new Exception("Ocorreu um erro ao tentar buscar o Fornecedor no banco de dados.", ex);
            }
            finally
            {
                cn.Close();
            }
        }
        enum Operacao
        {
            Inserir,
            Alterar,
            Excluir
        }
        private static void PreencherParametros(SqlCommand cmd, int _id)
        {
            PreencherParametros(new Fornecedor() { Id = _id }, cmd, Operacao.Excluir);
        }
        private static void PreencherParametros(Fornecedor _fornecedor, SqlCommand cmd, Operacao _operacao)
        {
            if (_operacao != Operacao.Excluir)
            {
                cmd.Parameters.AddWithValue("@Nome", _fornecedor.Nome);
                cmd.Parameters.AddWithValue("@CpfCnpj", _fornecedor.CpfCnpj);
                cmd.Parameters.AddWithValue("@Email", _fornecedor.Email);
                cmd.Parameters.AddWithValue("@Telefone", _fornecedor.Telefone);
                cmd.Parameters.AddWithValue("@Descricao", _fornecedor.Descricao);
                cmd.Parameters.AddWithValue("@Rua", _fornecedor.Rua);
                cmd.Parameters.AddWithValue("@CEP", _fornecedor.CEP);
                cmd.Parameters.AddWithValue("@Bairro", _fornecedor.Bairro);
                cmd.Parameters.AddWithValue("@Complemento", _fornecedor.Complemento);
                cmd.Parameters.AddWithValue("@NumeroCasa", _fornecedor.NumeroCasa);
                cmd.Parameters.AddWithValue("@Pais", _fornecedor.Pais);
                cmd.Parameters.AddWithValue("@Cidade", _fornecedor.Cidade);
                cmd.Parameters.AddWithValue("@Estado", _fornecedor.Estado);
            }
            if (_operacao != Operacao.Inserir)
                cmd.Parameters.AddWithValue("@Id", _fornecedor.Id);

            
        }

        public static Fornecedor PreencherObjeto(SqlDataReader rd)
        {
            Fornecedor fornecedor = new Fornecedor();
            fornecedor.Id = Convert.ToInt32(rd["Id"]);
            fornecedor.Nome = rd["Nome"].ToString();
            fornecedor.CpfCnpj = rd["CpfCnpj"].ToString();
            fornecedor.Email = rd["Email"].ToString();
            fornecedor.Telefone = rd["Telefone"].ToString();
            fornecedor.Descricao = rd["Descricao"].ToString();
            fornecedor.Rua = rd["Rua"].ToString();
            fornecedor.CEP = rd["CEP"].ToString();
            fornecedor.Bairro = rd["Bairro"].ToString();
            fornecedor.Complemento = rd["Complemento"].ToString();
            fornecedor.NumeroCasa = Convert.ToInt32(rd["NumeroCasa"]);
            fornecedor.Pais = rd["Pais"].ToString();
            fornecedor.Cidade = rd["Cidade"].ToString();
            fornecedor.Estado = rd["Estado"].ToString();
            return fornecedor;
        }

    }
}

