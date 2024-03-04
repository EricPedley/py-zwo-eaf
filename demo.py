from eaf_focuser import EAF, getNumEAFs, getEAFID

if __name__ == "__main__":
    eaf_count = getNumEAFs()

    print(f"Found {eaf_count} EAFs")

    if eaf_count < 1:
        print("No EAFs found")
        exit()

    eaf_id = getEAFID(0)

    eaf = EAF(eaf_id)

    print(f"Connected to EAF with ID {eaf_id}")
    print(f"Max position: {eaf.get_max_step()}")

    print(f"Current position: {eaf.get_position()}")

    while True:
        str_input = input("Enter position: ")
        if str_input == "exit" or str_input == "quit" or str_input == "q" or str_input == "e":
            break
        target_pos = int(str_input)
        eaf.move_to(target_pos)
        while eaf.is_moving():
            print(f"Moving to {target_pos}...")
            try:
                pos = eaf.get_position()
                print(f"Current position: {pos}")
                if pos == target_pos:
                    print("Reached target position")
                    eaf.stop()
                    break
            except Exception as e:
                print(f"Error: {e}")
                eaf.stop()
                break
        print(eaf.is_moving())