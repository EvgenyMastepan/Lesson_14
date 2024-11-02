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
 ● Ошибка .unknown: «Произошла неизвестная */

enum FileError: Error {
    case fileNotFound
    case insufficientPermission
    case unknown
}

func readFile(named: String) throws -> Result <String,FileError> {
    switch named {
    case "document.txt": return .success("Содержимое файла")
    case "restricted.txt": return .failure(.insufficientPermission)
    default: return .failure(.fileNotFound)
    }
}
