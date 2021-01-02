import SwiftPiGpioLib

public enum GPIOMode: UInt32 {
    case input = 0
    case output = 1
    case alt0 = 4
    case alt1 = 5
    case alt2 = 6
    case alt3 = 7
    case alt4 = 3
    case alt5 = 2
}

public enum GPIOLevel: UInt32 {
    case off = 0
    case on = 1
}

public enum GPIOPullUpDownMode: UInt32 {
    case off = 0
    case down = 1
    case up = 2
}


public enum GPIOError: Int32, Error {
    case invalidUserAllowedPin = -2
    case invalidPin = -3
    case invalidGPIOMode = -4
    case invalidLevel = -5
    case invalidPullUpDownMode = -6
    case invalidPulseWidth = -7
    case invalidDutyCycle = -8
    case invalidTimer = -9
    case invalidMs = -10
    case invalidTimeType = -11
    case invalidSeconds = -12
    case invalidMicros = -13
    case timerFailed = -14
    case invalidWatchdogTimer = -15
    case unknown = 9999
}

public class SwiftPiGpio {

    public static let shared = SwiftPiGpio()

    private init?(){
        if(gpioInitialise() < 0) {
            return nil
        }
    }

    deinit {
        gpioTerminate()
    }

    /**
        Throws error if status is less than 0

            - Parameter 
                - status: the status returned by gpio functions.

            - Throws: GPIOError mapped for gpio error integer constants.
    */
    
    func throwIfError(for status: Int32) throws {
        if status < 0 {
            let error = GPIOError(rawValue: status) ?? GPIOError.unknown
            throw error
        }
    }

    //MARK: BASIC GPIO FUNCTIONS

    public func setMode(pin: UInt32, mode: GPIOMode) throws {
        let status = gpioSetMode(pin, mode.rawValue)
        try throwIfError(for: status)
    }

    public func getMode(pin: UInt32) throws -> GPIOMode {
        let status = gpioGetMode(pin)
        
        try throwIfError(for: status)
        
        guard let mode = GPIOMode(rawValue: UInt32(status)) else {
            fatalError("gpioGetMode returned unknown value: \(status) for pin:\(pin)")
        }

        return mode
    }


    public func read(pin: UInt32) throws -> GPIOLevel {
        let status = gpioRead(pin)
        
        try throwIfError(for: status)

        guard let level = GPIOLevel(rawValue: UInt32(status)) else {
            fatalError("gpioRead returned unknown value: \(status) for pin:\(pin)")
        }

        return level
    }


    public func write(pin: UInt32, level: UInt32) throws {
        let status = gpioWrite(pin, level)
        try throwIfError(for: status)
    }

    //MARK: PWM FUNCTIONS

    public func pwmWrite(userPin: UInt32, dutyCycle: UInt32) throws {
        let status = gpioPWM(userPin, dutyCycle) 
        try throwIfError(for: status)
    }

    public func pwmRead(userPin: UInt32) throws -> Int32 {
        let status = gpioGetPWMdutycycle(userPin)
        try throwIfError(for: status)
        return status
    }

    public func pwmSetRange(userPin: UInt32, range: UInt32) throws {
        let status = gpioSetPWMrange(userPin, range)
        try throwIfError(for: status)
    }

}