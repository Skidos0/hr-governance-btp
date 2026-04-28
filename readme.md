# Cloud IT & HR Governance System (SAP CAP PoC) 🏢

## 📝 O projekcie
Ten projekt to **Proof of Concept (PoC)** systemu klasy Enterprise do zarządzania uprawnieniami i strukturą organizacyjną. Stworzyłem go, aby pokazać kompleksowe podejście do inżynierii oprogramowania: od zamodelowania procesu biznesowego i architektury (ArchiMate), przez zaprogramowanie logiki (SAP CAP) i zabezpieczeń (RBAC), aż po wygenerowanie interfejsu (Fiori) i konteneryzację (Docker).

System pozwala na:
* Przechowywanie danych o pracownikach i ich poziomach dostępu do chmury.
* Automatyczne, dynamiczne oznaczanie statusu weryfikacji tożsamości.
* Zarządzanie danymi poprzez profesjonalny interfejs SAP Fiori z obsługą wersji roboczych (Drafts).
* Egzekwowanie twardych reguł dostępu w zależności od roli użytkownika (Admin vs Auditor).

---

## 🏛️ Architektura Systemu
Jako inżynier i architekt, projekt rozpocząłem od zamodelowania schematu działania systemu zgodnie ze standardem **ArchiMate**, używając narzędzia Archi.

![Architektura Systemu](HR_Governance_Architecture.png)

### Co widać na schemacie?
1. **Warstwa Biznesowa (Żółta):** Pokazuje proces, w którym Audytor sprawdza, czy pracownicy mają poprawne dostępy.
2. **Warstwa Aplikacji (Niebieska):** To rdzeń systemu napisany w SAP CAP, wystawiający dane przez profesjonalne API (OData V4).
3. **Warstwa Technologii (Zielona):** Fundamenty, na których opiera się rozwiązanie (baza danych oraz systemy zarządzania tożsamością).

---

## 🚀 Główne Funkcjonalności (Wdrożone)

* **Role-Based Access Control (RBAC):** Rygorystyczne zarządzanie uprawnieniami na poziomie API za pomocą adnotacji `@restrict`. 
  * `Admin` (użytkownik *alice*) – pełen dostęp (CRUD).
  * `Auditor` (użytkownik *bob*) – dostęp "Read-Only". Próby modyfikacji danych są blokowane przez serwer błędem `403 Forbidden`.
* **Frontend SAP Fiori Elements:** Zaawansowany interfejs użytkownika z włączoną obsługą `@odata.draft.enabled`, co zapewnia integralność danych podczas edycji (List Report & Object Page).
* **DevOps / Konteneryzacja:** Aplikacja jest zoptymalizowana i gotowa do wdrożenia w chmurze dzięki plikom `Dockerfile` (z optymalizacją warstw Cache) oraz `.dockerignore`.
* **Automatyczne Testy API:** Dołączony plik `.rest` / `.http` pozwala na natychmiastową weryfikację bezpieczeństwa endpointów.

---

## ⚖️ Decyzje Architektoniczne (ADR)
Sekcja ta demonstruje świadomość ograniczeń technologicznych oraz uzasadnia kluczowe wybory projektowe.

### 1. Dlaczego Microsoft Entra ID (Azure AD) jest "udawany" (Mocked)?
* **Problem:** Prawdziwa integracja z Microsoft Azure wymagałaby posiadania uprawnień Administratora Globalnego w zewnętrznym tenancie oraz rejestracji płatnej aplikacji korporacyjnej.
* **Rozwiązanie:** Zastosowałem wzorzec **Mock Service**. W pliku `srv/admin-service.js` napisałem tzw. Custom Handler, który w locie "udaje" odpowiedź z serwerów Microsoftu, dopisując w interfejsie flagę `[Zweryfikowano w Entra ID]`.
* **Wniosek:** System zachowuje pełną architekturę i logikę działania. Po otrzymaniu prawdziwych kluczy API, podmiana Mocka na faktyczne zapytanie HTTP to kwestia zmiany kilkunastu linijek kodu, bez ruszania całego szkieletu aplikacji.

### 2. Wybór Bazy Danych i Konteneryzacja
* **Decyzja:** Zastosowanie bazy SQLite `in-memory` dla środowiska developerskiego, połączone z konteneryzacją (Docker).
* **Zaleta:** Pozwala to na natychmiastowe testowanie logiki (RBAC, Drafty) bez obciążeń związanych z konfiguracją ciężkich baz danych (jak HANA) na wczesnym etapie, przy zachowaniu 100% przenośności kodu dzięki kontenerom.

---

## 🛠️ Stos Technologiczny
* **Backend:** SAP Cloud Application Programming Model (CAP), Node.js, Express
* **Frontend:** SAP Fiori Elements, OData V4
* **Baza Danych:** SQLite (dane predefiniowane w plikach CSV)
* **DevOps & Architektura:** Docker, ArchiMate
* **Security & Testy:** REST Client, mechanizmy uwierzytelniania CAP (Mock Auth)

---

## 💻 Instrukcja Uruchomienia

### Przez Dockera
Wymaga jedynie zainstalowanego oprogramowania Docker Desktop.

### 1. Zbuduj obraz aplikacji
docker build -t hr-app .

### 2. Uruchom kontener
docker run -p 4004:4004 hr-app

## 🛡️ Weryfikacja Bezpieczeństwa (API / RBAC)

W głównym katalogu projektu znajduje się plik testowy `test.http` (kompatybilny z wtyczką REST Client dla VS Code/Cursor). Służy on do natychmiastowej weryfikacji zaimplementowanych reguł kontroli dostępu (Role-Based Access Control).

Dzięki niemu możesz samodzielnie przetestować, jak serwer reaguje na żądania użytkowników o różnych uprawnieniach:

* ✅ **Admin (`alice`)** – posiada pełne uprawnienia (CRUD). Zapytania kończą się sukcesem (`200 OK` / `204 No Content`).
* ⛔ **Auditor (`bob`)** – posiada dostęp wyłącznie do odczytu (Read-Only). 

**Przykład działania blokady:**
Wysłanie żądania `DELETE` jako Audytor (`bob`) w celu usunięcia rekordu skutkuje twardą blokadą na poziomie backendu:
> **Wynik:** Odrzucenie zapytania ze statusem `HTTP 403 Forbidden`.

To ostatecznie potwierdza, że system zabezpiecza dane nie tylko poprzez ukrywanie przycisków w interfejsie Fiori, ale przede wszystkim na najniższym poziomie architektury API.

---
*Projekt stworzony jako demonstracja umiejętności z zakresu SAP Cloud i Architektury IT.*