module.exports = (srv) => {
    srv.after('READ', 'Employees', (each, req) => {
        // Symulacja połączenia z API Microsoft Entra ID (Azure AD)
        // W prawdziwym środowisku tutaj byłby fetch() do Microsoft Graph API

        console.log(`[MOCK AZURE AD] Weryfikacja tożsamości dla: ${each.name}... OK`);

        // Dodaj notatkę tylko dla użytkowników z rolą 'Admin'
        if (req.user && req.user.is('Admin')) {
            each.department += ' [Zweryfikowano w Entra ID]';
        }
    });
};