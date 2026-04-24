module.exports = (srv) => {
    srv.after('READ', 'Employees', (each) => {
        // Symulacja połączenia z API Microsoft Entra ID (Azure AD)
        // W prawdziwym środowisku tutaj byłby fetch() do Microsoft Graph API
        
        
        console.log(`[MOCK AZURE AD] Weryfikacja tożsamości dla: ${each.name}... OK`);
        
        // Dodajemy wirtualną flagę z Azure do naszego API
        each.department += ' (Verified via Azure Mock)';
    });
};