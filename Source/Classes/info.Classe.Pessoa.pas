unit info.Classe.Pessoa;

interface

Type

 TEndereco = class
 private
    FLogradouro: string;
    FBairro: string;
    FCep: string;
    FNumero: string;
    FComplemento: string;
    FCidade: string;
    FPais: string;
    FEstado: string;
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetPais(const Value: string);
 published
  property Cep         :string read FCep write SetCep;
  property Logradouro  :string read FLogradouro write SetLogradouro;
  property Numero      :string read FNumero write SetNumero;
  property Complemento :string read FComplemento write SetComplemento;
  property Bairro      :string read FBairro write SetBairro;
  property Cidade      :string read FCidade write SetCidade;
  property Estado      :string read FEstado write SetEstado;
  property Pais        :string read FPais write SetPais;
 public

 end;


 TPessoa = class
 Private
    FEmail: string;
    FCPF: string;
    FIdentidade: string;
    FNome: string;
    FEndereco: TEndereco;
    FTelefone: string;
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetIdentidade(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetTelefone(const Value: string);

 published
  property Nome       :string read FNome write SetNome;
  property Identidade :string read FIdentidade write SetIdentidade;
  property CPF        :string read FCPF write SetCPF;
  property Telefone   :string read FTelefone write SetTelefone;
  property Email      :string read FEmail write SetEmail;
  property Endereco   :TEndereco read FEndereco write SetEndereco;
 public

    Constructor Create;
    Destructor  Destroy; Override;

    Function Get_Pessoa(CPF:String; vResult:String):TPessoa;
    Function Set_Pessoa(Pessoa:TPessoa; vResult:String):Boolean;

 end;



implementation

{ TEndereco }

uses info.funcoes;

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TEndereco.SetPais(const Value: string);
begin
  FPais := Value;
end;

{ TPessoa }

constructor TPessoa.Create;
begin

end;

destructor TPessoa.Destroy;
begin

  inherited;
end;

function TPessoa.Get_Pessoa(CPF:String; vResult: String): TPessoa;
begin

end;

procedure TPessoa.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TPessoa.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TPessoa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetIdentidade(const Value: string);
begin
  FIdentidade := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

function TPessoa.Set_Pessoa(Pessoa: TPessoa; vResult: String): Boolean;
begin
 try
  gravar_pessoa_xml(Pessoa.Nome,Pessoa.Identidade,Pessoa.CPF,Pessoa.Telefone,Pessoa.Email,
                    Pessoa.Endereco.Cep,Pessoa.Endereco.Logradouro,Pessoa.Endereco.Numero,
                    Pessoa.Endereco.Complemento,Pessoa.Endereco.Bairro,Pessoa.Endereco.Cidade,
                    Pessoa.Endereco.Estado,Pessoa.Endereco.Pais);
  result := true;
 except
  result := false;
 end;
end;

end.
