unit Server.Models.Ativo.DadosLigacao.Factory;

interface

uses Server.Models.Ativo.DadosLigacao, Generics.Collections;

type

  TFactoryComprasItem = class
  public
    class function CriarComprasItem: TComprasItem; Overload;
    class function CriarComprasItem(
      pDESCONTO: Double;
      pQDT: Integer;
      pDESCRICAO: String;
      pUN_MEDIDA: String;
      pVALOR_UN: Double;
      pCODPROD: String
      ): TComprasItem; Overload;
  end;

  TFactoryCompras = class
  public
    class function CriarCompras: TCompras; Overload;
    class function CriarCompras
      (pVALOR: Double; pDESCRICAO: String;
       pCODIGO: Integer; pFORMA_PGTO: String;
       pDATA: TDate; pItens: TObjectList<TObject>): TCompras; Overload;
  end;

  TFactoryAgenda = class
  public
    class function CriarAgenda: TAgenda; Overload;
    class function CriarAgenda
      (pCAMPANHA: String;
       pCODIGO: Integer;
       pOPERADOR: String;
       pDT_AGENDAMENTO: TDateTime;
       pDT_RESULTADO: TDateTime;
       pFONE2: String;
       pRESULTADO: String;
       pFONE1: String;
       pOPERADOR_LIGACAO, pPROPOSTA: String): TAgenda; Overload;
  end;

  TFactoryHistorico = class
  public
    class function CriarHistorico: THistorico; Overload;
    class function CriarHistorico
      (pTIPO_LIGACAO: String;
       pCAMPANHA: String;
       pCODIGO: Integer;
       pFIM: TDateTime;
       pOPERADOR: String;
       pINICIO: TDateTime;
       pRESULTADO: String;
       pTELEFONE, pOBSERVACAO, pCOR: String): THistorico; Overload;
  end;


implementation

{ TFactoryComprasItem }

uses Infotec.Utils;

class function TFactoryComprasItem.CriarComprasItem: TComprasItem;
begin
  Result := TComprasItem.Create;
end;

class function TFactoryComprasItem.CriarComprasItem(pDESCONTO: Double;
  pQDT: Integer; pDESCRICAO, pUN_MEDIDA: String; pVALOR_UN: Double;
  pCODPROD: String): TComprasItem;
begin
  Result := CriarComprasItem;
  Result.CODPROD := pCODPROD;
  Result.DESCRICAO := TInfotecUtils.RemoverEspasDuplas(pDESCRICAO);
  Result.QDT := pQDT;
  Result.UN_MEDIDA := pUN_MEDIDA;
  Result.VALOR_UN := pVALOR_UN;
  Result.DESCONTO := pDESCONTO;
end;

{ TFactoryCompras }

class function TFactoryCompras.CriarCompras: TCompras;
begin
  Result := TCompras.create;
end;

class function TFactoryCompras.CriarCompras(pVALOR: Double; pDESCRICAO: String;
  pCODIGO: Integer; pFORMA_PGTO: String; pDATA: TDate;
  pItens: TObjectList<TObject>): TCompras;
var
  vItem:TObject;
begin
 Result := CriarCompras;
 Result.CODIGO := pCODIGO;
 Result.DATA := pDATA;
 Result.DESCRICAO := TInfotecUtils.RemoverEspasDuplas(pDESCRICAO);
 Result.VALOR := pVALOR;
 Result.FORMA_PGTO := pFORMA_PGTO;

 for vItem in pItens do
 begin
   Result.Itens.Add(TComprasItem(vItem));
 end;
end;

{ TFactoryAgenda }

class function TFactoryAgenda.CriarAgenda: TAgenda;
begin
  Result := TAgenda.Create;
end;

class function TFactoryAgenda.CriarAgenda(pCAMPANHA: String; pCODIGO: Integer;
  pOPERADOR: String; pDT_AGENDAMENTO, pDT_RESULTADO: TDateTime; pFONE2,
  pRESULTADO, pFONE1, pOPERADOR_LIGACAO, pPROPOSTA: String): TAgenda;
begin
  Result := CriarAgenda;
  Result.CODIGO := pCODIGO;
  Result.DT_AGENDAMENTO := pDT_AGENDAMENTO;
  Result.FONE1 := pFONE1;
  Result.FONE2 := pFONE2;
  Result.OPERADOR := pOPERADOR;
  Result.OPERADOR_LIGACAO := pOPERADOR_LIGACAO;
  Result.RESULTADO := pRESULTADO;
  Result.DT_RESULTADO := pDT_RESULTADO;
  Result.CAMPANHA := pCAMPANHA;
  Result.PROPOSTA := pPROPOSTA;
end;

{ TFactoryHistorico }

class function TFactoryHistorico.CriarHistorico: THistorico;
begin
  Result := THistorico.Create;
end;

class function TFactoryHistorico.CriarHistorico(pTIPO_LIGACAO,
  pCAMPANHA: String; pCODIGO: Integer; pFIM: TDateTime; pOPERADOR: String;
  pINICIO: TDateTime; pRESULTADO, pTELEFONE, pOBSERVACAO, pCOR: String): THistorico;
begin
  Result := CriarHistorico;
  Result.TIPO_LIGACAO := pTIPO_LIGACAO;
  Result.CAMPANHA := pCAMPANHA;
  Result.CODIGO := pCODIGO;
  Result.FIM := pFIM;
  Result.OPERADOR := pOPERADOR;
  Result.INICIO := pINICIO;
  Result.RESULTADO:= pRESULTADO;
  Result.TELEFONE := pTELEFONE;
  Result.OBSERVACAO := TInfotecUtils.RemoverEspasDuplas(pOBSERVACAO);
  Result.COR := pCOR;
end;

end.
