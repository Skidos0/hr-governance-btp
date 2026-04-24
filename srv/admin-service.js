module.exports = (srv) => {
    srv.after('READ', 'Employees', (each) => {
        // Symulacja połączenia z API Microsoft Entra ID (Azure AD)
        // W prawdziwym środowisku tutaj byłby fetch() do Microsoft Graph API
        
        
        console.log(`[MOCK AZURE AD] Weryfikacja tożsamości dla: ${each.name}... OK`);
        
        // Mockowanie statusu z entra id (azure ad)
        each.department += ' (Verified via Azure Mock)';
    });
};