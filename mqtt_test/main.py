from datetime import datetime
import struct
import paho.mqtt.client as mqtt


def on_connect(client, userdata, flags, rc):
    print("Connected to the broker.")

    client.subscribe("ela/project/#")


def on_message(client, userdata, msg):
    topics = msg.topic.split("/")
    if len(topics) != 5:
        print("Message sent to bad topic", msg.topic)
        return

    name = topics[2]
    client_id = topics[3]
    sensor_id = topics[4]

    try:
        ts, itemp, apa = struct.unpack(">Ii", msg.payload)

        temp = itemp / 1000
        date = datetime.fromtimestamp(ts)

        if date.year < 2023:
            print("The timestamp looks wrong", date)
            return
        
        if temp < -20 or temp > 50:
            print("The temperature looks wrong", temp)
            return

        print(f"{name} - {client_id} - {sensor_id} - {date} - {temp}°C")
    except struct.error:
        print("Message with bad payload", msg.payload)


def main():
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    client.connect("broker.hivemq.com", 1883, 60)

    client.loop_forever()


if __name__ == "__main__":
    main()
