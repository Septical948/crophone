@echo off
echo Generacion de interfaces Topaz-Altair
echo.
Color 4A

REM Datos de conexion
SET SERVIDOR= UYASDBMT1
SET BASE_DATOS= Santander

REM - Para todas las interfaces, tomo la ruta destino de la siguiente consulta: SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000

REM - Cancelo todas las negociaciones de LCI que hayan pasado a ACTIV y no se hayan pago
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_NEXLiquidacionAutomaticaNegociacionesLCI  @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"

REM - Contabilidad
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=1"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=1"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 01/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Contabilidad @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+ClaveInterfaz+FechaContable+FechaOperacion+Producto+Subproducto+Garantia+TipoPlazo+Plazo+Residente+SectorBE+CNAE+EmpresaTutelada+Ambito+Morosidad+Inversion+TipoObligacion+RubroContable+Moneda+TipoMoneda+TipoNominal+Mnemonico+Varios+ClaveAutorizacion+CentroOperante+CentroOrigen+CentroDestino+CodigoMovimientoAlDebe+CodigoMovimientoAlHaber+ImporteAlDebeUYU+ImporteAlHaberUYU+ImporteAlDebe+ImporteAlHaber+IndicadorCorreccion+NroControl+ClaveConcepto+DescripcionConcepto+TipoConcepto+DescripcionClaveInterfaz+NroOperacion+AplicacionOrigen+AplicacionDestino+NroVoucher+Reservado+CodigoMovimiento+NroOperador+TipoBase+Cuenta+CodigoEvento+Comision FROM Interfaz_Contabilidad WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 380 -h-1


REM - COC
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=2"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=2"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 02/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Contabilidad_COC @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+ClaveInterfaz+FechaContable+FechaOperacion+Producto+Subproducto+Garantia+TipoPlazo+Plazo+Residente+SectorBE+CNAE+EmpresaTutelada+Ambito+Morosidad+Inversion+TipoObligacion+RubroContable+Moneda+TipoMoneda+TipoNominal+Mnemonico+Varios+ClaveAutorizacion+CentroOperante+CentroOrigen+CentroDestino+CodigoMovimientoAlDebe+CodigoMovimientoAlHaber+ImporteAlDebeUYU+ImporteAlHaberUYU+ImporteAlDebe+ImporteAlHaber+IndicadorCorreccion+NroControl+ClaveConcepto+DescripcionConcepto+TipoConcepto+DescripcionClaveInterfaz+NroOperacion+AplicacionOrigen+AplicacionDestino+NroVoucher+Reservado+CodigoMovimiento+NroOperador+TipoBase+Cuenta FROM Santander.dbo.Interfaz_Contabilidad_COC (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 374 -h-1


REM - Personas - Contrato
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=3"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=3"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 03/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Personas_Contrato @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+NroOperacion+Sucursal+EntidadOperacion+Producto+Subproducto+Moneda+SucursalOperacion+Oficial+CanalVenta+OficialVenta+OficialComercial+Saldo+SaldoPromedio+FechaInicio+FechaTermino+EstadoContrato+FechaEstado+MotivoEstado+SubEstado+NumeroRelacionBancario+PaquetePertenencia+CantidadTexto+DescripcionTexto+TipoMovimiento FROM Santander.dbo.Interfaz_Personas_Contrato (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 276 -h-1


REM - Personas - Cliente Contrato
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=4"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=4"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 04/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Personas_ClienteContrato @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+NroPersona+NroOperacion+SucursalOperacion+Entidad2+TipoTitularidad+OrdenParticipacion+Producto+Subproducto+FechaBaja+EstadoDelContrato+PorcentajeResponsabilidad+MarcaVerificacionPaquete+MotivoDeBaja+TipoDocumento+NroDocumento+UsuarioAlta+FechaAltaoBaja+UsuarioModificacion+TerminalModificacion+SucursalModificacion+FechaHoraModificacion+TipoMovimiento FROM Santander.dbo.Interfaz_Personas_ClienteContrato (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 136 -h-1


REM - Dynatech
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=5"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=5"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 05/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q  "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Dynatech @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q  "SET nocount on; SELECT CASE WHEN EXISTS (SELECT 1 FROM Interfaz_Dynatech WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)) THEN 'H' + convert(VARCHAR(8),(SELECT FechaProcesoAnterior FROM Parametros),112) + substring(convert(VARCHAR(5),CONVERT(TIME,(SELECT FechaProcesoAnterior FROM Parametros),100)),1,2) + substring(convert(VARCHAR(5),CONVERT(TIME,(SELECT FechaProcesoAnterior FROM Parametros),100)),4,2) + replicate(' ',314) ELSE '' END UNION ALL SELECT IdentificacionDeLinea+NroOperacion+NroOperacionDynatech+TipoDocumento+NroDocumento+SucursalCliente+SucursalOperacion+FechaOperacionDynatech+HoraOperacionDynatech+FechaOperacion+HoraOperacion+TipoOperacion+MonedaOrigen+MonedaDestino+ImporteMonedaOrigen+ImporteMonedaDestino+CotizacionCompraMercado+CotizacionCompraPizarra+CotizacionCompraOperacion+CotizacionVentaMercado+CotizacionVentaPizarra+CotizacionVentaOperacion+MnemonicoOrigen+CuentaOrigen+MnemonicoDestino+CuentaDestino+NombreUsuarioDeIngreso+UsuarioDeIngreso+UsuarioDeAprobacion+Observaciones FROM Interfaz_Dynatech WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros) UNION ALL SELECT CASE WHEN EXISTS (SELECT 1 FROM Interfaz_Dynatech WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)) THEN 'F' + replicate('0',6 - datalength(CONVERT(VARCHAR(6),count(*)))) + convert(VARCHAR(6),count(*)) + replicate(' ',320) ELSE '' END FROM Interfaz_Dynatech WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 327 -h-1


REM - Dynatech - Incidencias
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=6"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=6"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 06/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Compra/Venta de Moneda
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=7"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=7"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 07/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Compra/Venta de Moneda - Control
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=8"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=8"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 08/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Ordenes de Pago
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=9"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=9"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 09/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Ordenes de Pago - Control
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=10"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=10"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 10/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Movimientos Diarios y Eventos
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=11"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=11"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 11/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT ''" -o %Interfaz% -Y 0 -h-1
type nul > %Interfaz%


REM - ODS - Movimientos Diarios y Eventos - Eventos
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=12"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=12"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 12/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Mensual Diario
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=13"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=13"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 13/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_ODS_Diario @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+Sucursal+NroOperacion+Producto+Subproducto+Secuencia+SucursalOperacion+FechaAlta+SignoImporte+Importe+SignoImporteUYU+ImporteUYU+FechaVencimientoActual+FechaVencimientoOriginal+SignoIntereses+Intereses+SignoInteresesUYU+InteresesUYU+SignoSaldoDisponibleUYU+SaldoDisponibleUYU+SignoSaldoDisponible+SaldoDisponible+Moneda+NroPersona FROM Santander.dbo.Interfaz_ODS_Diario (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 182 -h-1


REM - ODS - Mensual Diario - Control
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=14"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=14"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 14/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Mensual
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=15"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=15"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 15/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Mensual - Control
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=16"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=16"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 16/37 - %NombreArchivo%
type nul > %Interfaz%


REM - ODS - Cliente Contrato de Transferencias
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=17"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=17"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 17/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_ODS_ClienteContratoTransferencia @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+NumeroPersona+NroOperacion+SucursalOperacion+EntidadPersona+TipoTitularidad+OrdenParticipacion+Producto+Subproducto+FechaBaja+EstadoDelContrato+PorcentajeResponsabilidad+MarcaPaquete+MotivoDeBaja+TipoDocumento+NroDocumento+UsuarioAlta+FechaProceso+UsuarioModificacion+TerminalModificacion+SucursalModificacion+TimeStamp+TipoMovimiento+Moneda FROM Interfaz_ODS_ClienteContratoTransferencia WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 140 -h-1


REM - ODS - Cliente Contrato de Transferencias - Control
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=18"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=18"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 18/37 - %NombreArchivo%
type nul > %Interfaz%


REM - AKON - Contabilidad
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=19"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=19"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 19/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Akon_Contabilidad @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT CASE WHEN EXISTS (SELECT 1 FROM Interfaz_Akon_Contabilidad WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)) THEN 'BANKTRADE' + replicate(' ',20 - datalength('BANKTRADE')) + convert(VARCHAR(8), (SELECT FechaProcesoAnterior FROM Parametros), 112) + substring(CAST(CAST(getdate() AS TIME) AS VARCHAR), 1, 8) + replicate(' ',151) ELSE '' END UNION ALL SELECT NroAkon+NroReembolso+CodigoMovimiento+ImporteEntero+ImporteSeparacion+ImporteDecimal+NroOperacion+SucursalCuenta+ReferenciaOperacion+replicate(' ', 15)+Varios_1+Varios_2+Varios_3+Varios_4+FechaContable+Varios_5+FechaContable_1+FechaContable_2+Varios_6+Producto+Subproducto+CuentaContableAltair+Moneda+TipoDocumento+NroDocumento FROM Interfaz_Akon_Contabilidad WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros) UNION ALL SELECT CASE WHEN EXISTS (SELECT 1 FROM Interfaz_Akon_Contabilidad WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)) THEN replicate('0',10 - datalength(CAST(count(*) AS VARCHAR))) + CAST(count(*) AS VARCHAR) + isnull(replicate('0',17 - datalength(replace(CAST(sum(CAST(ImporteEntero AS DECIMAL(15,2))) + sum(CAST(ImporteDecimal AS DECIMAL(15,2))/100) AS VARCHAR),'.',''))) + replace(CAST(sum(CAST(ImporteEntero AS DECIMAL(15,2))) + sum(CAST(ImporteDecimal AS DECIMAL(15,2))/100) AS VARCHAR),'.',''), replicate('0',17)) + substring(CAST(CAST(getdate() AS TIME) AS VARCHAR), 1, 8) + replicate(' ',152) ELSE '' END FROM Interfaz_Akon_Contabilidad WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 186 -h-1


REM - AKON - Contabilidad - Incidencias
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=20"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=20"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 20/37 - %NombreArchivo%
type nul > %Interfaz%


REM - AKON - ALADI
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=21"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=21"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 21/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Akon_ALADI @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT RubroBCU+NroOperacion+Moneda+Saldo FROM Santander.dbo.Interfaz_Akon_ALADI (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 41 -h-1


REM - Garra - Cobranzas Vigentes
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=22"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=22"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 22/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_CobranzasVigentes @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+Sucursal+NroOperacion+Producto+Subproducto+Moneda+CentroOperante+TipoDeCambio+FechaApertura+FechaVencimientoInicial+FechaVencimientoActual+FechaInicioGracia+FechaFinGracia+FechaPrimerImpagoCBE+FechaAltaCastigoParcial+FechaAltaCastigoTotal+FechaDeQuita+FechaPrimerImpagoCBL+PeriodicidadAmortizacionCuotas+TasaInteres+Plazo+TipoTitularidad+DestinosFondos+RotacionCancelacion+CodigoParticipacion+OrigenRiesgo+SituacionContrato+FechaProximaLiquidacion+FechaUltimaLiquidacion+TasaInteresReferencia+TipoDeTasa+TasaInteresMoratorio+FrecuenciaRegularizacion+CantidadDiasImpagos+PeriodoGracia+CantidadIncumplimientos+CuotaActual+CuotasTotales+CantidadExcesos+CuotasPendientes+CuotasImpagadas+CantidadChequesDevueltos+CantidadEfectosEmitidos+CantidadEfectosDev1Mes+CantidadEfectosDev3Mes+CantidadEfectosDev6Mes+CodigoRubro+IndicadorAportacionGarantias+IndicadorNovacion+IndicadorRescisionContrato+IndicadorRiesgo+IndicadorRefinanciamiento+Indicador_LineaMadre+CodigoOficina_LineaRelacionada+NroOperacion_LineaRelacionada+Producto_LineaRelacionada+Subproducto_LineaRelacionada+MonedaGestion+FuenteRecursos+PorcentajeParticipacion+ProgramaApoyo+PorcentajeDescuento+ImporteLimite+ImporteLimiteUYU+ImporteDispuestoPorElCliente+ImporteDispuestoPorElClienteUYU+ImporteMinimoDispuesto+ImporteMinimoDispuestoUYU+ImporteMaximoDispuesto+ImporteMaximoDispuestoUYU+ImporteDeudaContable+ImporteDeudaContableUYU+ImporteDeudaTotal+ImporteDeudaTotalUYU+ImporteTotalEmitido+ImporteTotalEmitidoUYU+CapitalImpagadoEnEfectosA1Mes+CapitalImpagadoEnEfectosA1MesUYU+CapitalImpagadoEnEfectosA3Mes+CapitalImpagadoEnEfectosA3MesUYU+CapitalImpagadoEnEfectosA6Mes+CapitalImpagadoEnEfectosA6MesUYU+CapitalNoVencido+CapitalNoVencidoUYU+CapitalImpagado+CapitalImpagadoUYU+ImporteImpagadoSeguro+ImporteImpagadoSeguroUYU+InteresesImpagados+InteresesImpagadosUYU+ImpuestosImpagados+ImpuestosImpagadosUYU+GastosReclamablesAludor+GastosReclamablesAludorUYU+SaldoPromedio+SaldoPromedioUYU+ImporteUtilizadoParaInflacion+ImporteUtilizadoParaInflacionUYU+ImporteEntregadoACuenta+ImporteEntregadoACuentaUYU+HabilitacionFondosGastos+HabilitacionFondosGastosUYU+ComisionesImpagadas+ComisionesImpagadasUYU+ImporteCondonadoNegoc+ImporteCondonadoUYUNegoc+InteresesNoLlevadosAResultados+InteresesNoLlevadosAResultadosUYU+InteresesvengadosVencidos+InteresesvengadosVencidosUYU+InteresesvengadosAVencer+InteresesvengadosAVencerUYU+Comisionesvengadas+ComisionesvengadasUYU+ComisionesNoLlevadoAResultado+ComisionesNoLlevadoAResultadoUYU+ImporteCastigado+ImporteCastigadoUYU+ImporteDisponible+ImporteDisponibleUYU+ImportePagadoEnElUltimoMes+ImportePagadoEnElUltimoMesUYU+CuotaQuePagaElClienteRegUYU+CuotaQuePagaElClienteReg+CapitalExigible+CapitalExigibleUYU+InteresesExigibles+InteresesExigiblesUYU+CapitalNoExigible+CapitalNoExigibleUYU+InteresesNoExigibles+InteresesNoExigiblesUYU+ImporteTotalExigible+ImporteTotalExigibleUYU+ImporteAudoTotalSir+ImporteAudoTotalSirUYU+TipoActualizacionlRegistro+FehaActualizacionlRegistro+FechaProceso+Filler FROM Santander.dbo.Interfaz_GARRA_CobranzasVigentes (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 1657 -h-1


REM - Garra - Pagos de Operaciones
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=23"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=23"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 23/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_Pagos @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT EntidadGeneral+NroPersona+Entidad+Sucursal+NroOperacion+Producto+Subproducto+Moneda+LineaMadre+SucursalLineaDeActivo+NroOperacionLineaDeActivo+ProductoLineaDeActivo+SubproductoLineaDeActivo+MonedaLineaDeActivo+PeriodoAmortizacion+TipoTasa+FechaVencimientoInicial+FechaVencimientoActual+Reactivado+ImporteCastigado+ImporteCastigadoUYU+ImportePagado+ImportePagadoUYU+FechaPago+FechaPrimerImpago+Saldo+SaldoUYU+ImporteExigible+ImporteExigibleUYU+ImporteCapitalNoExigible+ImporteCapitalNoExigibleUYU+InteresesNoExigible+InteresesNoExigibleUYU+ImporteTotalExigible+ImporteTotalExigibleUYU+ImporteAdeudadoTotal+ImporteAdeudadoTotalUYU+FechaProceso+NroDocumento+Filler FROM Santander.dbo.Interfaz_GARRA_Pagos (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 438 -h-1


REM - Garra - LC Vigentes
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=24"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= %
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=24"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 24/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_LCVigentes @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+Sucursal+NroOperacion+Producto+Subproducto+Moneda+CentroOperante+TipoDeCambio+FechaApertura+FechaVencimientoInicial+FechaVencimientoActual+FechaInicioGracia+FechaFinGracia+FechaPrimerImpagoCBE+FechaAltaCastigoParcial+FechaAltaCastigoTotal+FechaDeQuita+FechaPrimerImpagoCBL+PeriodicidadAmortizacionCuotas+TasaInteres+Plazo+TipoTitularidad+DestinosFondos+RotacionCancelacion+CodigoParticipacion+OrigenRiesgo+SituacionContrato+FechaProximaLiquidacion+FechaUltimaLiquidacion+TasaInteresReferencia+TipoDeTasa+TasaInteresMoratorio+FrecuenciaRegularizacion+CantidadDiasImpagos+PeriodoGracia+CantidadIncumplimientos+CuotaActual+CuotasTotales+CantidadExcesos+CuotasPendientes+CuotasImpagadas+CantidadChequesDevueltos+CantidadEfectosEmitidos+CantidadEfectosDev1Mes+CantidadEfectosDev3Mes+CantidadEfectosDev6Mes+CodigoRubro+IndicadorAportacionGarantias+IndicadorNovacion+IndicadorRescisionContrato+IndicadorRiesgo+IndicadorRefinanciamiento+Indicador_LineaMadre+CodigoOficina_LineaRelacionada+NroOperacion_LineaRelacionada+Producto_LineaRelacionada+Subproducto_LineaRelacionada+MonedaGestion+FuenteRecursos+PorcentajeParticipacion+ProgramaApoyo+PorcentajeDescuento+ImporteLimite+ImporteLimiteUYU+ImporteDispuestoPorElCliente+ImporteDispuestoPorElClienteUYU+ImporteMinimoDispuesto+ImporteMinimoDispuestoUYU+ImporteMaximoDispuesto+ImporteMaximoDispuestoUYU+ImporteDeudaContable+ImporteDeudaContableUYU+ImporteDeudaTotal+ImporteDeudaTotalUYU+ImporteTotalEmitido+ImporteTotalEmitidoUYU+CapitalImpagadoEnEfectosA1Mes+CapitalImpagadoEnEfectosA1MesUYU+CapitalImpagadoEnEfectosA3Mes+CapitalImpagadoEnEfectosA3MesUYU+CapitalImpagadoEnEfectosA6Mes+CapitalImpagadoEnEfectosA6MesUYU+CapitalNoVencido+CapitalNoVencidoUYU+CapitalImpagado+CapitalImpagadoUYU+ImporteImpagadoSeguro+ImporteImpagadoSeguroUYU+InteresesImpagados+InteresesImpagadosUYU+ImpuestosImpagados+ImpuestosImpagadosUYU+GastosReclamablesAludor+GastosReclamablesAludorUYU+SaldoPromedio+SaldoPromedioUYU+ImporteUtilizadoParaInflacion+ImporteUtilizadoParaInflacionUYU+ImporteEntregadoACuenta+ImporteEntregadoACuentaUYU+HabilitacionFondosGastos+HabilitacionFondosGastosUYU+ComisionesImpagadas+ComisionesImpagadasUYU+ImporteCondonadoNegoc+ImporteCondonadoUYUNegoc+InteresesNoLlevadosAResultados+InteresesNoLlevadosAResultadosUYU+InteresesvengadosVencidos+InteresesvengadosVencidosUYU+InteresesvengadosAVencer+InteresesvengadosAVencerUYU+Comisionesvengadas+ComisionesvengadasUYU+ComisionesNoLlevadoAResultado+ComisionesNoLlevadoAResultadoUYU+ImporteCastigado+ImporteCastigadoUYU+ImporteDisponible+ImporteDisponibleUYU+ImportePagadoEnElUltimoMes+ImportePagadoEnElUltimoMesUYU+CuotaQuePagaElClienteRegUYU+CuotaQuePagaElClienteReg+CapitalExigible+CapitalExigibleUYU+InteresesExigibles+InteresesExigiblesUYU+CapitalNoExigible+CapitalNoExigibleUYU+InteresesNoExigibles+InteresesNoExigiblesUYU+ImporteTotalExigible+ImporteTotalExigibleUYU+ImporteAudoTotalSir+ImporteAudoTotalSirUYU+TipoActualizacionlRegistro+FehaActualizacionlRegistro+FechaProceso+Filler FROM Santander.dbo.Interfaz_GARRA_LCVigentes (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 1657 -h-1


REM - Garra - LC a Vencer
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=25"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=25"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 25/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_LCAVencer @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+Sucursal+NroOperacion+Producto+Subproducto+Moneda+FechaVencimiento+Importe+ImporteUYU+TipoRegistro+FechaTipoRegistro+FechaProceso FROM Santander.dbo.Interfaz_GARRA_LCAVencer (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 94 -h-1


REM - Garra - Contratos Envejecidos
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=26"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=26"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 26/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_LCEnvejecidas @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT Entidad+Sucursal+NroOperacion+Producto+Subproducto+Moneda+CentroOperante+TipoDeCambio+FechaApertura+FechaVencimientoInicial+FechaVencimientoActual+FechaInicioGracia+FechaFinGracia+FechaPrimerImpagoCBE+FechaAltaCastigoParcial+FechaAltaCastigoTotal+FechaDeQuita+FechaPrimerImpagoCBL+PeriodicidadAmortizacionCuotas+TasaInteres+Plazo+TipoTitularidad+DestinosFondos+RotacionCancelacion+CodigoParticipacion+OrigenRiesgo+SituacionContrato+FechaProximaLiquidacion+FechaUltimaLiquidacion+TasaInteresReferencia+TipoDeTasa+TasaInteresMoratorio+FrecuenciaRegularizacion+CantidadDiasImpagos+PeriodoGracia+CantidadIncumplimientos+CuotaActual+CuotasTotales+CantidadExcesos+CuotasPendientes+CuotasImpagadas+CantidadChequesDevueltos+CantidadEfectosEmitidos+CantidadEfectosDev1Mes+CantidadEfectosDev3Mes+CantidadEfectosDev6Mes+CodigoRubro+IndicadorAportacionGarantias+IndicadorNovacion+IndicadorRescisionContrato+IndicadorRiesgo+IndicadorRefinanciamiento+Indicador_LineaMadre+CodigoOficina_LineaRelacionada+NroOperacion_LineaRelacionada+Producto_LineaRelacionada+Subproducto_LineaRelacionada+MonedaGestion+FuenteRecursos+PorcentajeParticipacion+ProgramaApoyo+PorcentajeDescuento+ImporteLimite+ImporteLimiteUYU+ImporteDispuestoPorElCliente+ImporteDispuestoPorElClienteUYU+ImporteMinimoDispuesto+ImporteMinimoDispuestoUYU+ImporteMaximoDispuesto+ImporteMaximoDispuestoUYU+ImporteDeudaContable+ImporteDeudaContableUYU+ImporteDeudaTotal+ImporteDeudaTotalUYU+ImporteTotalEmitido+ImporteTotalEmitidoUYU+CapitalImpagadoEnEfectosA1Mes+CapitalImpagadoEnEfectosA1MesUYU+CapitalImpagadoEnEfectosA3Mes+CapitalImpagadoEnEfectosA3MesUYU+CapitalImpagadoEnEfectosA6Mes+CapitalImpagadoEnEfectosA6MesUYU+CapitalNoVencido+CapitalNoVencidoUYU+CapitalImpagado+CapitalImpagadoUYU+ImporteImpagadoSeguro+ImporteImpagadoSeguroUYU+InteresesImpagados+InteresesImpagadosUYU+ImpuestosImpagados+ImpuestosImpagadosUYU+GastosReclamablesAludor+GastosReclamablesAludorUYU+SaldoPromedio+SaldoPromedioUYU+ImporteUtilizadoParaInflacion+ImporteUtilizadoParaInflacionUYU+ImporteEntregadoACuenta+ImporteEntregadoACuentaUYU+HabilitacionFondosGastos+HabilitacionFondosGastosUYU+ComisionesImpagadas+ComisionesImpagadasUYU+ImporteCondonadoNegoc+ImporteCondonadoUYUNegoc+InteresesNoLlevadosAResultados+InteresesNoLlevadosAResultadosUYU+InteresesvengadosVencidos+InteresesvengadosVencidosUYU+InteresesvengadosAVencer+InteresesvengadosAVencerUYU+Comisionesvengadas+ComisionesvengadasUYU+ComisionesNoLlevadoAResultado+ComisionesNoLlevadoAResultadoUYU+ImporteCastigado+ImporteCastigadoUYU+ImporteDisponible+ImporteDisponibleUYU+ImportePagadoEnElUltimoMes+ImportePagadoEnElUltimoMesUYU+CuotaQuePagaElClienteRegUYU+CuotaQuePagaElClienteReg+CapitalExigible+CapitalExigibleUYU+InteresesExigibles+InteresesExigiblesUYU+CapitalNoExigible+CapitalNoExigibleUYU+InteresesNoExigibles+InteresesNoExigiblesUYU+ImporteTotalExigible+ImporteTotalExigibleUYU+ImporteAudoTotalSir+ImporteAudoTotalSirUYU+TipoActualizacionlRegistro+FehaActualizacionlRegistro+FechaProceso+Filler FROM Santander.dbo.Interfaz_GARRA_LCEnvejecidas (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 1657 -h-1


REM - Garra - Contratos Envejecidos 2
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=27"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=27"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 27/37 - %NombreArchivo%
type nul > %Interfaz%


REM - Garra - Disponible de Linea
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=28"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=28"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 28/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_GARRA_LineasCreditoLCI @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT PaisDocumento+TipoDocumento+NroDocumento+NroPersona+AnioLinea+NumeroLinea+CodigoAgrupacion+EntidadContrato+SucursalContrato+Entidad+Sucursal+NroOperacion+Producto+Subproducto+Saldo+Moneda+Plazo+Usuario+Opcion FROM Santander.dbo.Interfaz_GARRA_LineasCreditoLCI (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 106 -h-1


REM  - Préstamos
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=29"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=29"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 29/37 - %NombreArchivo%
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; DECLARE @p_id_proceso INT = 1 DECLARE @p_ret_proceso INT DECLARE @p_msg_proceso VARCHAR(4000) BEGIN EXEC sp_Interfaz_Prestamos @p_id_proceso, '20200101', @p_ret_proceso OUT, @p_msg_proceso OUT END"
for /f %%G in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT COUNT(*) FROM Santander.dbo.Interfaz_Prestamos (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)"') do set CantidadRegistros="%%G"
if %CantidadRegistros% NEQ "0" goto HayPrestamos
goto NoHayPrestamos

:HayPrestamos
sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on; SELECT CASE WHEN EXISTS (SELECT 1 FROM Santander.dbo.Interfaz_Prestamos (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)) THEN '1' + CONVERT(VARCHAR(10),(SELECT FechaProcesoAnterior FROM Santander.dbo.Parametros (nolock)),23) + 'BNT' + '   CARTAS DE CREDITO VENCIDAS' + replicate(' ',125) ELSE '' END UNION ALL SELECT TipoRegistro+Entidad+Sucursal+Producto+Subproducto+Moneda+Importe+FechaAlta+Tasa+TipoTasa+SituacionDeuda+EntidadVinculada+SucursalVinculada+NroOperacionVinculada+ProductoVinculado+SubproductoVinculado+MonedaVinculada+EntidadOrigen+SucursalOrigen+NroOperacion+TituloEjecutivo+OficialVenta+TipoDocumentoDedudor+NroDocumentoDedudor+NroPersonaDeudor+TipoTitularidad+OrdenParticipacion+PorcentajeParticipacion+TitularPrincipal+Spread+OficinaContable+IndicadorLinea+Filler FROM Santander.dbo.Interfaz_Prestamos (nolock) WHERE FechaEjecucion = (SELECT FechaProcesoAnterior FROM Parametros)" -o %Interfaz% -Y 169 -h-1
goto SiguienteInterfaz

:NoHayPrestamos
type nul > %Interfaz%
goto SiguienteInterfaz


:SiguienteInterfaz
REM - UIAF - Compra/Venta de Moneda
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=30"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=30"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 30/37 - %NombreArchivo%
type nul > %Interfaz%


REM - UIAF - Transferencias
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=31"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=31"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 31/37 - %NombreArchivo%
type nul > %Interfaz%


REM - SWIFT - 940
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=32"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=32"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 32/37 - %NombreArchivo%
type nul > %Interfaz%


REM - SWIFT - 940FA
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=33"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=33"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 33/37 - %NombreArchivo%
type nul > %Interfaz%


REM - SWIFT - 103
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=34"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=34"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 34/37 - %NombreArchivo%
type nul > %Interfaz%


REM - MSW
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=35"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=35"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 35/37 - %NombreArchivo%
type nul > %Interfaz%


REM - Dynatech - Incidencias 1
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=36"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=36"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 36/37 - %NombreArchivo%
type nul > %Interfaz%


REM - Dynatech - Incidencias 2
for /f %%A in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT (SELECT Valor FROM ParametrosVarios WHERE Codigo = 1000)+NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','')+'.txt' FROM Interfaz_NombresArchivos WHERE Id=37"') do set RutaArchivo="%%A"
SET Interfaz=%RutaArchivo:/= % 
for /f %%D in ('sqlcmd -S %SERVIDOR% -d %BASE_DATOS% -I -Q "set nocount on;SELECT NombreArchivo+'_'+replace(convert(VARCHAR,(SELECT FechaProcesoAnterior FROM Parametros),2),'.','') FROM Interfaz_NombresArchivos WHERE Id=37"') do set Nombre=%%D
SET NombreArchivo=%Nombre:/= % 
echo 37/37 - %NombreArchivo%
type nul > %Interfaz%

PAUSE
EXIT
