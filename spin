<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lucky Spin Wheel</title>
    <style>
        #wheel {
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: conic-gradient(
                red 0% 20%, 
                yellow 20% 40%, 
                green 40% 60%, 
                pink 60% 80%, 
                orange 80% 100%
            );
            position: relative;
            margin: 200px auto 0; /* Move the wheel down 200px */
        }

        /* Center black circle */
        #wheel::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 15px;
            height: 15px;
            background: black;
            border-radius: 50%;
            transform: translate(-50%, -50%);
        }

        /* Prize text styles */
        .prize {
            position: absolute;
            top: 50%;
            left: 50%;
            transform-origin: 50% 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: -10px; /* Center text vertically */
            color: black; /* Set text color to white */
            font-weight: bold; /* Make text bold */
            font-size: 16px; /* Adjust font size if needed */
        }

        .prize:nth-child(1) {
            transform: rotate(-40deg) translateX(120%) translateY(-220%);
            width: 20%;
        }
        .prize:nth-child(2) {
            transform: rotate(25deg) translateX(120%) translateY(20%);
            width: 20%;
        }
        .prize:nth-child(3) {
            transform: rotate(90deg) translateX(150%) translateY(150%);
            width: 20%;
        }
        .prize:nth-child(4) {
            transform: rotate(-25deg) translateX(-200%) translateY(-120%);
            width: 20%;
        }
        .prize:nth-child(5) {
            transform: rotate(40deg) translateX(-200%) translateY(-10%);
            width: 20%;
        }

        /* Pointer styles */
        #pointer {
            width: 0;
            height: 0;
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 30px solid black;
            position: fixed; /* Use 'fixed' so it stays with respect to the screen */
            top: 180px; /* Move the pointer down by 200px */
            left: 50%;
            transform: translateX(-50%) rotate(180deg);
            z-index: 1; /* Ensure the pointer is above the wheel */
        }

        /* Modal styles */
        #prizeModal {
            display: none; /* Hidden by default */
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* Dark overlay */
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            width: 300px;
        }

        .modal-content button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: green;
            color: white;
            border: none;
            cursor: pointer;
        }

        .modal-content button.close-btn {
            background-color: red;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div id="pointer"></div> <!-- Move pointer outside the wheel -->
    <div id="wheel">
        <div class="prize">Prize 1</div>
        <div class="prize">Prize 2</div>
        <div class="prize">Prize 3</div>
        <div class="prize">Prize 4</div>
        <div class="prize">Prize 5</div>
    </div>
    <button onclick="spin()">Spin the Wheel!</button>

    <!-- Modal for showing the prize -->
    <div id="prizeModal">
        <div class="modal-content">
            <h2 id="modalMessage">Congrats! You won prize X</h2>
            <button id="getPrizeBtn">Get the prize</button>
            <button class="close-btn" onclick="closeModal()">Close</button>
        </div>
    </div>

    <script>
        let prizeURLs = {
            1: "https://survey.emolyzer.com/ai/form/cb6a71cd-fc24-4bc2-affa-a7644dc179d8?prize=1",
            2: "https://survey.emolyzer.com/ai/form/cb6a71cd-fc24-4bc2-affa-a7644dc179d8?prize=2",
            3: "https://survey.emolyzer.com/ai/form/cb6a71cd-fc24-4bc2-affa-a7644dc179d8?prize=3",
            4: "https://survey.emolyzer.com/ai/form/cb6a71cd-fc24-4bc2-affa-a7644dc179d8?prize=4",
            5: "https://survey.emolyzer.com/ai/form/cb6a71cd-fc24-4bc2-affa-a7644dc179d8?prize=5"
        };

        function spin() {
            const wheel = document.getElementById('wheel');
            const deg = Math.floor(5000 + Math.random() * 5000); // Randomize rotation
            const baseRotation = deg % 360; // Get the remainder to determine final stopping angle

            wheel.style.transition = 'all 5s ease-out';
            wheel.style.transform = `rotate(${deg}deg)`;

            // Wait until the spin animation finishes (5 seconds)
            setTimeout(() => {
                checkPrize(baseRotation); // Check the prize after the spin
            }, 5000);
        }

        function checkPrize(rotation) {
            // Normalize the angle within a 0-360 degree range
            const finalRotation = rotation > 0 ? 360 - rotation : -rotation;
            let prizeNumber = 0;

            // Determine which sector the pointer is pointing to
            if (finalRotation >= 0 && finalRotation < 72) {
                prizeNumber = 1;
            } else if (finalRotation >= 72 && finalRotation < 144) {
                prizeNumber = 2;
            } else if (finalRotation >= 144 && finalRotation < 216) {
                prizeNumber = 3;
            } else if (finalRotation >= 216 && finalRotation < 288) {
                prizeNumber = 4;
            } else if (finalRotation >= 288 && finalRotation <= 360) {
                prizeNumber = 5;
            }

            // Show modal with the prize
            document.getElementById("modalMessage").innerText = `Congrats! You won prize ${prizeNumber}`;
            document.getElementById("getPrizeBtn").onclick = function() {
                window.open(prizeURLs[prizeNumber], "_blank");
            };
            document.getElementById("prizeModal").style.display = "flex"; // Show the modal
        }

        function closeModal() {
            document.getElementById("prizeModal").style.display = "none"; // Hide modal and return to spin
        }
    </script>
</body>
</html>
