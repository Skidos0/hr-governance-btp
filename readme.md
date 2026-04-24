# Cloud IT Governance & Asset Monitor (PoC)

## 📋 Opis Projektu
Projekt typu Proof of Concept (PoC) opracowany w celu zademonstrowania kompetencji w zakresie **Enterprise Architecture**, **SAP BTP (Business Technology Platform)** oraz procesów **IT Governance**. 

Aplikacja symuluje scentralizowany system zarządzania uprawnieniami chmurowymi pracowników w dużej organizacji. System integruje dane kadrowe z poziomami dostępu do infrastruktury chmurowej, wspierając audytorów bezpieczeństwa w weryfikacji dostępów (Identity & Access Management).

## 🏛️ Architektura Systemu (ArchiMate)
Poniższy diagram przedstawia architekturę rozwiązania zgodnie ze standardem **ArchiMate 3.1**, dzieląc system na warstwę biznesową, aplikacyjną i technologiczną.

![Architektura Systemu](HR_Governance_Architecture.png)

### Kluczowe założenia architektoniczne:
* **Business Layer:** Audytor IT wykonuje proces weryfikacji dostępów przy użyciu dedykowanego interfejsu.
* **Application Layer:** Mikroserwis zbudowany w modelu **SAP CAP (Node.js)** wystawiający API w standardzie **OData V4**.
* **Technology Layer:** Wykorzystanie bazy **SAP HANA** oraz symulacja integracji z **Microsoft Entra ID (Azure AD)** w celu walidacji tożsamości.

## 🛠️ Stos Technologiczny
* **Platforma:** SAP Business Technology Platform (BTP)
* **Framework:** SAP Cloud Application Programming Model (CAP)
* **Backend:** Node.js (Runtime)
* **Protokół:** OData V4
* **Baza danych:** SQLite (In-memory for Dev) / SAP HANA
* **Modelowanie:** ArchiMate (Narzędzie: Archi)

## 🚀 Funkcje i Implementacja
1.  **Zarządzanie Zasobami:** Automatyczne mapowanie ról pracowniczych na poziomy dostępu (Admin, Developer, Auditor).
2.  **IT Governance Logic:** Implementacja niestandardowej logiki w Node.js (`admin-service.js`), która weryfikuje statusy kont w zewnętrznych systemach IDP (Mock Azure AD).
3.  **Standard Enterprise:** Wykorzystanie wbudowanych pól audytowych SAP (`managed`), śledzących czas utworzenia i modyfikacji każdego rekordu.

## 📈 Potencjał Rozwojowy
* Implementacja pełnej integracji z **Microsoft Graph API**.
* Budowa frontendu w **SAP Fiori/UI5** dla audytorów.
* Wdrożenie mechanizmów **Role-Based Access Control (RBAC)** bezpośrednio w SAP XSUAA.

---
*Projekt przygotowany jako element portfolio kandydata na stanowiska związane z Architekturą IT i Ekosystemem SAP.*