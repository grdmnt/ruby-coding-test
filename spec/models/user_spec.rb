# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".email_history" do
    subject(:user) { FactoryBot.create(:user, email: "test@email.com") }

    before do
      user.update(email: "new@email.com")
    end

    it "returns past emails" do
      expect(user.email_history.first[:email]).to eq "test@email.com"
    end
  end

  describe ".is_admin?" do
    subject(:user) { FactoryBot.create(:user, type: "Admin") }

    it "returns true" do
      expect(user.is_admin?).to be true
    end
  end

  describe "validations" do
    subject { described_class.new(params)}

    context "when invalid email format" do
      let(:params) do
        { email: "teom", first_name: "Alice", last_name: "Go" }
      end

      it { is_expected.to be_invalid }
    end

    context "when missing email" do
      let(:params) do
        { email: "", first_name: "Alice", last_name: "Go" }
      end

      it { is_expected.to be_invalid }
    end

    context "when missing first_name" do
      let(:params) do
        { email: "test@email.com", first_name: "", last_name: "Go" }
      end

      it { is_expected.to be_invalid }
    end

    context "when missing last_name" do
      let(:params) do
        { email: "test@email.com", first_name: "Alice", last_name: "" }
      end

      it { is_expected.to be_invalid }
    end
  end
end
