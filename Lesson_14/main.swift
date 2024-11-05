//
//  swift 9th stream
//  Lesson_14
//
//  Created by Evgeny Mastepan on 02.11.2024.
//

import Foundation

/* Создайте перечисление FileError, соответствующее протоколу Error, с вариантами:
 ● .fileNotFound — если файл не найден.
 ● .insufficientPermissions — если нет прав
 доступа к файлу.
 ● .unknown — для всех других ошибок.
 Напишите функцию readFile(named:), которая принимает имя файла (String) и возвращает Result<String, FileError>. Функция должна:
 ● Возвращать .success с содержимым файла, если имя файла — "document.txt".
 ● Возвращать .failure(.fileNotFound) для любого другого имени файла.
 ● Возвращать .failure(.insufficientPermissions) для имени файла "restricted.txt".
 Напишите код, который вызывает readFile(named:) и обрабатывает результат с помощью switch. Для каждого случая выводите сообщение в консоль:
 ● Успешное чтение: «Содержимое файла: <содержимое>».
 ● Ошибка .fileNotFound: «Файл не найден».
 ● Ошибка .insufficientPermissions: «Нет прав
 доступа к файлу».
 ● Ошибка .unknown: «Произошла неизвестная ошибка» */

enum FileError: Error {
    case fileNotFound
    case insufficientPermission
    case unknown
}

func readFile(named: String) -> Result<String, FileError> {
    switch named {
        case "document.txt": return .success("Содержимое файла document.txt")
        case "restricted.txt": return .failure(.insufficientPermission)
        default: return .failure(.fileNotFound)
    }
}

let fileName = "document.txt"
let result = readFile(named: fileName)

switch result {
case .success(let content):
    print("Содержимое файла: \(content)")
case .failure(let error):
    switch error {
    case .fileNotFound:
        print("Файл не найден.")
    case .insufficientPermission:
        print("Нет прав доступа к файлу.")
    case .unknown:
        print("Произошла неизвестная ошибка.")
    }
}


/* Создайте перечисление CalculationError, соответствующее протоколу Error, с вариантами:
 ● .divisionByZero — если происходит деление на ноль.
 ● .negativeNumber — если получено отрицательное число,
 где оно не допускается.
 Напишите функцию divide(_:, by:), которая принимает два числа (Double) и возвращает результат деления. Функция должна выбрасывать ошибку .divisionByZero, если второй параметр равен нулю.
 Напишите функцию squareRoot(of:), которая принимает число и возвращает его квадратный корень. Функция должна выбрасывать ошибку .negativeNumber, если передано отрицательное значение.
 Создайте функцию calculate(), которая:
 Вызывает divide(_:by:) и затем squareRoot(of:), используя результат деления.
 Использует do-catch для обработки ошибок на каждом шаге и выводит сообщение для каждого типа ошибки:
 ○ Ошибка .divisionByZero: «Ошибка: деление на ноль».
 ○ Ошибка .negativeNumber: «Ошибка: корень из отрицательного числа».
 Вызовите calculate() с различными параметрами, включая случаи, где возможно деление на ноль и отрицательное значение.
 */

enum CalculationError: Error {
    case divisionByZero
    case negativeNumber
}

func divide(_ first: Double, by second: Double) throws -> Double {
    if second == 0 {
        throw CalculationError.divisionByZero
    }
    return first / second
}

func squareRoot(of number: Double) throws -> Double {
    if number < 0 {
        throw CalculationError.negativeNumber
    }
    return sqrt(number)
}

func calculate(dividend: Double, divisor: Double) {
    do {
        let result = try divide(dividend, by: divisor)
        let squareRootResult = try squareRoot(of: result)
        print("Квадратный корень: \(squareRootResult)")
    } catch CalculationError.divisionByZero {
        print("Ошибка: деление на ноль.")
    } catch CalculationError.negativeNumber {
        print("Ошибка: корень из отрицательного числа недопустим.")
    } catch {
        print("Произошла неизвестная ошибка.")
    }
}
calculate(dividend: 53, divisor: 4)
calculate(dividend: 7, divisor: 0)
calculate(dividend: -14, divisor: 56)
calculate(dividend: 185, divisor: -4)

/* Создайте перечисление NetworkError, соответствующее протоколу Error, с вариантами:
 ● .notConnected — если отсутствует подключение.
 ● .timeout — если истекло время ожидания. Напишите две функции:
 ● fetchUserProfile(), возвращающую Result<String, NetworkError>, которая случайным образом возвращает либо успешный результат .success("Профиль пользователя загружен"), либо ошибку .notConnected.
 ● fetchUserOrders(), возвращающую Result<String, NetworkError>, которая случайным образом возвращает либо успешный результат .success("Заказы пользователя загружены"), либо ошибку .timeout.
 Напишите функцию loadUserData, которая:
 ● Использует цепочку Result для вызова сначала
 fetchUserProfile(), а затем, при успешном
 результате, fetchUserOrders().
 ● В случае успешного выполнения всех вызовов выводит:
 «Все данные загружены: Профиль и Заказы».
 ● В случае ошибки выводит сообщение для каждого типа
 ошибки:
 ○ Ошибка .notConnected: «Ошибка загрузки:
 отсутствует подключение».
 ○ Ошибка .timeout: «Ошибка загрузки: превышено
 время ожидания». */

enum NetworkError: Error {
    case notConnected
    case timeout
}

func fetchUserProfile() -> Result<String, NetworkError> {
    let success = Bool.random()
    if success {
        return .success("Профиль пользователя загружен")
    } else {
        return .failure(.notConnected)
    }
}

func fetchUserOrders() -> Result<String, NetworkError> {
    let success = Bool.random()
    if success {
        return .success("Заказы пользователя загружены")
    } else {
        return .failure(.timeout)
    }
}

func loadUserData() {
    let profileResult = fetchUserProfile()
    switch profileResult {
    case .success(let profileMessage):
        print(profileMessage)
        let ordersResult = fetchUserOrders()
        switch ordersResult {
        case .success(let ordersMessage):
            print(ordersMessage)
            print("Все данные загружены: Профиль и Заказы")
        case .failure(let error):
            if error == .timeout {
                print ("Ошибка загрузки: превышено время ожидания")
            }
        }
    case .failure(let error):
        if error == .notConnected {
            print("Ошибка загрузки: отсутствует подключение")
        }
    }
}

loadUserData()

/* Создайте перечисление PaymentError, соответствующее протоколу Error, с вариантами:
 ● .insufficientFunds — если средств на счете недостаточно.
 ● .invalidCard — если карта недействительна.
 ● .transactionError — для других ошибок.
 Напишите функцию processPayment(amount:), которая выбрасывает ошибки:
 ● .insufficientFunds, если amount больше 1000.
 ● .invalidCard, если amount меньше или равно нулю.
 ● В остальных случаях выводит сообщение об успешной оплате.
 Используйте do-catch для вызова processPayment(amount:) и обработайте ошибки следующим образом:
 ● Ошибка .insufficientFunds: «Недостаточно средств для оплаты».
 ● Ошибка .invalidCard: «Неверная карта».
 ● Ошибка .transactionError: «Произошла ошибка при
 обработке транзакции».
 Вызовите функцию с различными суммами, включая граничные случаи для каждой ошибки.
   */

enum PaymentError: Error {
    case insufficientFunds
    case invalidCard
    case transactionError
}

func processPayment(amount: Double) throws {
    if amount > 1000 {
        throw PaymentError.insufficientFunds
    } else if amount <= 0 {
        throw PaymentError.invalidCard
    } else {
        print("Оплата на сумму \(amount) выполнена успешно.")
    }
}

func makePayment(with amount: Double) {
    do {
        try processPayment(amount: amount)
    } catch PaymentError.insufficientFunds {
        print("Недостаточно средств для оплаты.")
    } catch PaymentError.invalidCard {
        print("Неверная карта.")
    } catch {
        print("Произошла ошибка при обработке транзакции.")
    }
}

makePayment(with: 24.58)
makePayment(with: 5420)
makePayment(with: 0)
makePayment(with: -200)
makePayment(with: 640)
makePayment(with: 1000)
